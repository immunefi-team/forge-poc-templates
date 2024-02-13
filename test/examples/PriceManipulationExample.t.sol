// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/pricemanipulation/examples/PriceManipulationExample.sol";

contract PriceManipulationExampleTest is Test {
    uint256 mainnetFork;

    PriceManipulationExample public attackContract;

    function setUp() public {
        mainnetFork = vm.createFork("eth", 18464488);
        vm.selectFork(mainnetFork);

        attackContract = new PriceManipulationExample();
    }

    function testPriceManipulationAttack() public {
        attackContract.initiateAttack();
    }
}
