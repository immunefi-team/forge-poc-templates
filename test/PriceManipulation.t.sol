// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PriceManipulationTemplate.sol";

contract PriceManipulationTest is Test {
    uint256 mainnetFork;

    PriceManipulationTemplate public attackContract;

    function setUp() public {
        mainnetFork = vm.createFork("eth");
        vm.selectFork(mainnetFork);

        attackContract = new PriceManipulationTemplate();
    }

    function testPriceManipulationAttack() public {
        attackContract.initiateAttack();
    }
}
