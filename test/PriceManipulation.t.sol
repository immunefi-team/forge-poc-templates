// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PriceManipulationTemplate.sol";

contract PriceManipulationTest is Test {
    uint256 mainnetFork;
    string RPC_URL = vm.envString("RPC_URL");

    PriceManipulationTemplate public attackContract;

    function setUp() public {
        mainnetFork = vm.createFork(RPC_URL);
        vm.selectFork(mainnetFork);

        attackContract = new PriceManipulationTemplate();
    }

    function testPriceManipulationAttack() public {
        attackContract.initiateAttack();
    }
}
