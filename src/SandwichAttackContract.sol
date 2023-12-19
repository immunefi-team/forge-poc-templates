// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@immunefi/src/PoC.sol";

contract SandwichAttackContract is PoC {
    function frontRun() external {
        console.log("\n>>> Front running");
    }
    
    function backRun() external {
        console.log("\n>>> Back running");
    }
}
