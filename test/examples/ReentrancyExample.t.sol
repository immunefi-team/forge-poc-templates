pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/reentrancy/examples/ReentrancyExampleAttack.sol";
import "../../src/reentrancy/examples/ReentrancyExampleVictim.sol";

contract ReentrancyExampleTest is Test {
    ReentrancyExampleAttack public attackContract;
    ReentrancyExampleVictim public victimContract;

    function setUp() public {
        victimContract = new ReentrancyExampleVictim();
        attackContract = new ReentrancyExampleAttack(address(victimContract));
        deal(address(attackContract), 1 ether);
        deal(address(victimContract), 2 ether);
    }

    function testReentrancyAttack() public {
        attackContract.initiateAttack();
    }
}
