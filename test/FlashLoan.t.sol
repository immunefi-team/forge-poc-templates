// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/flashloan/examples/FlashLoanExample.sol";

contract FlashLoanTest is Test {
    uint256 mainnetFork;
    string RPC_URL = vm.envString("RPC_URL");

    FlashLoanExample public flashLoanExample;

    function setUp() public {
        mainnetFork = vm.createFork(RPC_URL);
        vm.selectFork(mainnetFork);

        flashLoanExample = new FlashLoanExample();
    }

    function testFlashLoan() public {
        flashLoanExample.initiateAttack();
    }
}
