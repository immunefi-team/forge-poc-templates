// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@immunefi/src/reentrancy/Reentrancy.sol";
import "@immunefi/src/PoC.sol";

contract AttackContract is Reentrancy, PoC {
    function initializeAttack() public {
        // Trigger reentrancy callback
        address(this).call("");
    }

    function _executeAttack() internal override {
        // _executeAttack() is called when the reentrancy callback is triggered, since we extend the Reentrancy contract
        _completeAttack();
    }

    function _completeAttack() internal override {
        console.log("\n>>> Complete attack");
    }
}
