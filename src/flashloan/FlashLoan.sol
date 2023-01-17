pragma solidity ^0.8.0;

import "./FlashLoanProvider.sol";

import "forge-std/console.sol";

abstract contract Flashloan {
    FlashLoanProviders internal _flp;
    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider and token
     * @param flp The address of the flash loan provider to take the loan from
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, address token, uint256 amount) public virtual {
        console.log("Taking flashloan of %s %s from FlashLoanProviders[%s]", amount, token, uint256(flp));
        _flp = flp;
        FlashLoanProvider.takeFlashLoan(flp, token, amount);
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
     */
    fallback() external payable virtual {
        console.log("Execute attack");
        _executeAttack();
        console.log("Pay back flashloan");
        FlashLoanProvider.payFlashLoan(_flp);
        console.log("Attack completed successfully");
        _completeAttack();
    }
}
