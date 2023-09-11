pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";

import "./FlashLoanProvider.sol";

import "forge-std/console.sol";

abstract contract FlashLoan {
    using FlashLoanProvider for FlashLoanProviders;

    /**
     * @dev Flash loan provider call stack
     */
    FlashLoanProviders[] internal _flps;

    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider
     * @param flp The flash loan provider to take the loan from
     * @param tokens The addresses of the tokens to borrow
     * @param amounts The amounts of the tokens to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, IERC20[] memory tokens, uint256[] memory amounts) internal virtual {
        address[] memory tkns = new address[](tokens.length);
        for (uint256 i = 0; i < tokens.length; i++) {
            console.log("\n>>> Taking flashloan of %s %s from [%s]", amounts[i], tokens[i].symbol(), flp.name());
            tkns[i] = address(tokens[i]);
        }
        _flps.push(flp);
        flp.takeFlashLoan(tkns, amounts);
    }

    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider
     * @param flp The flash loan provider to take the loan from
     * @param tokens The addresses of the tokens to borrow
     * @param amounts The amounts of the tokens to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, address[] memory tokens, uint256[] memory amounts)
        internal
        virtual
    {
        for (uint256 i = 0; i < tokens.length; i++) {
            console.log("\n>>> Taking flashloan of %s %s from [%s]", amounts[i], tokens[i], flp.name());
        }
        _flps.push(flp);
        flp.takeFlashLoan(tokens, amounts);
    }

    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider
     * @param flp The address of the flash loan provider to take the loan from
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, IERC20 token, uint256 amount) internal virtual {
        takeFlashLoan(flp, address(token), amount);
    }

    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider
     * @param flp The address of the flash loan provider to take the loan from
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, address token, uint256 amount) internal virtual {
        console.log("\n>>> Taking flashloan of %s %s from [%s]", amount, token, flp.name());
        _flps.push(flp);
        flp.takeFlashLoan(token, amount);
        _flps.pop();
    }

    /**
     * @dev Returns the top most provider from the call stack
     * @return flp The current flash loan provider context
     */
    function currentFlashLoanProvider() internal view returns (FlashLoanProviders flp) {
        if (_flps.length > 0) {
            return _flps[_flps.length - 1];
        }
        return FlashLoanProviders.NONE;
    }

    /**
     * @dev Executes the attack logic for the flash loan
     */
    function _executeAttack() internal virtual;

    /**
     * @dev Completes the attack logic and finalizes the flash loan
     */
    function _completeAttack() internal virtual;

    function _fallback() internal virtual {
        console.log("\n>>> Execute attack");
        _executeAttack();
        if (_flps.length > 0) {
            FlashLoanProviders flp = currentFlashLoanProvider();
            if (flp.callbackFunctionSelector() == bytes4(msg.data[:4])) {
                console.log("\n>>> Attack completed successfully");
                _completeAttack();
                console.log("\n>>> Pay back flash loan");
                flp.payFlashLoan();
                bytes memory returnData = flp.returnData();
                assembly {
                    let len := mload(returnData)
                    return(add(returnData, 0x20), len)
                }
            }
        }
    }

    /**
     * @dev Fallback function that executes the attack logic, pays back the flash loan, and finalizes the attack
     * @dev First checks if there are any flash loans on the call stack
     * @dev Verifies the function selector matches the current providers callback function selector
     */
    fallback() external payable virtual {
        _fallback();
    }
}
