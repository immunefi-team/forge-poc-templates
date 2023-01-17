pragma solidity ^0.8.0;

import "./FlashloanProvider.sol";

abstract contract Flashloan {
    FlashloanProviders internal _flp;
    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider and token
     * @param flp The address of the flash loan provider to take the loan from
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(FlashloanProviders flp, address token, uint256 amount) public virtual {
        _flp = flp;
        FlashloanProvider.takeFlashLoan(flp, token, amount);
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
        _executeAttack();
        FlashloanProvider.payFlashLoan(_flp);
        _completeAttack();
    }
}
