// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/pricemanipulation/examples/PriceManipulationExample.sol";

contract PriceManipulationExampleTest is Test {
    uint256 mainnetFork;
    string RPC_URL = vm.envString("RPC_URL");

    PriceManipulationExample public attackContract;

    function setUp() public {
        mainnetFork = vm.createFork(RPC_URL);
        vm.selectFork(mainnetFork);
        
        attackContract = new PriceManipulationExample();
    }

    function testReentrancyAttack() public {
        attackContract.initiateAttack();
    }
}
