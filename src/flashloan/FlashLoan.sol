pragma solidity ^0.8.0;

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
    function takeFlashLoan(FlashLoanProviders flp, address[] memory tokens, uint256[] memory amounts) public virtual {
        for (uint256 i = 0; i < tokens.length; i++) {
            console.log("Taking flashloan of %s %s from FlashLoanProviders[%s]", amounts[i], tokens[i], uint256(flp));
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
    function takeFlashLoan(FlashLoanProviders flp, address token, uint256 amount) public virtual {
        console.log("Taking flashloan of %s %s from FlashLoanProviders[%s]", amount, token, uint256(flp));
        _flps.push(flp);
        flp.takeFlashLoan(token, amount);
    }

    /**
     * @dev Returns the top most provider from the call stack
     * @return flp The current flash loan provider context
     */
    function currentProvider() internal returns (FlashLoanProviders flp) {
        require(_flps.length > 0, "FlashLoan: No current flash loan provider");
        return _flps[_flps.length - 1];
    }

    /**
     * @dev Executes the attack logic for the flash loan
     */
    function _executeAttack() internal virtual;

    /**
     * @dev Completes the attack logic and finalizes the flash loan
     */
    function _completeAttack() internal virtual;

    /**
     * @dev Fallback function that executes the attack logic, pays back the flash loan, and finalizes the attack
     * @dev First checks if there are any flash loans on the call stack
     * @dev Verifies the function selector matches the current providers callback function selector
     */
    fallback() external payable virtual {
        if (_flps.length > 0) {
            FlashLoanProviders flp = currentProvider();
            if (flp.callbackFunctionSelector() == bytes4(msg.data[:4])) {
                console.log("Execute attack");
                _executeAttack();
                console.log("Pay back flash loan");
                flp.payFlashLoan();
                console.log("Attack completed successfully");
                _completeAttack();
                _flps.pop();
                bytes32 returnData = flp.returnData();
                assembly {
                    mstore(0x0, returnData)
                    return(0x0, 0x80)
                }
            }
        }
    }
}
