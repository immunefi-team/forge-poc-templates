pragma solidity ^0.8.0;

import "./FlashLoanProvider.sol";

import "forge-std/console.sol";

abstract contract Flashloan {
    /**
     * @dev Flash loan provider call stack
     */
    FlashLoanProviders[] internal _flps;

    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider and token
     * @param flp The address of the flash loan provider to take the loan from
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, address token, uint256 amount) public virtual {
        console.log("Taking flashloan of %s %s from FlashLoanProviders[%s]", amount, token, uint256(flp));
        _flps.push(flp);
        FlashLoanProvider.takeFlashLoan(flp, token, amount);
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
            if (FlashLoanProvider.callbackFunctionSelector(flp) == bytes4(msg.data[:4])) {
                console.log("Execute attack");
                _executeAttack();
                console.log("Pay back flash loan");
                FlashLoanProvider.payFlashLoan(flp);
                console.log("Attack completed successfully");
                _completeAttack();
                _flps.pop();
            }
        }
    }
}
