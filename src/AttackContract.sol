// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@immunefi/src/PoC.sol";

contract AttackContract is PoC {
    function initializeAttack() public {
        console.log("\n>>> Initalize attack");
        _executeAttack();
    }

    function _executeAttack() internal {
        console.log("\n>>> Execute attack");
        EthereumTokens.USDC.transfer(address(0xdead), 1 * 10 ** 10);
        _completeAttack();
    }
    
    function _completeAttack() internal {
        console.log("\n>>> Complete attack");
    }
}