// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ReentrancyTemplate.sol";

contract ReentrancyTest is Test {
    ReentrancyTemplate public attackContract;
    address victimContract = address(0x0); // Modify this to be your victim contract

    function setUp() public {
        attackContract = new ReentrancyTemplate(address(victimContract));
    }

    function testReentrancyAttack() public {
        attackContract.initiateAttack();
    }
}
