pragma solidity ^0.8.0;

import "../reentrancy/Reentrancy.sol";

abstract contract PriceManipulation is Reentrancy {
    /**
     * @dev Executes the attack logic for the price manipulation
     */
    function _executeAttack() internal virtual override;

    /**
     * @dev Completes the attack logic
     */
    function _completeAttack() internal virtual override;

    /**
     * @dev Function run when target contract makes external call back to attack contract
     */
    function _reentrancyCallback() internal virtual override {
        _executeAttack();
        _completeAttack();
    }
}
