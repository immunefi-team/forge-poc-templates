// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Reentrancy/ReentrancyAttack.sol";
import "../src/Reentrancy/ReentrancyVictim.sol";

contract ReentrancyTest is Test {
    Reentrancy public attackContract;
    ReentrancyVictim public victimContract;

    function setUp() public {
        victimContract = new ReentrancyVictim();
        attackContract = new ReentrancyAttack(address(victimContract));
        deal(address(attackContract), 1 ether);
        deal(address(victimContract), 5 ether);
    }

    function testAttack() public {
        attackContract.initiateAttack();
    }
}
