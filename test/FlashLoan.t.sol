pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FlashLoanTemplate.sol";

contract FlashLoanTest is Test {
    uint256 mainnetFork;
    string RPC_URL = vm.envString("RPC_URL");

    FlashLoanTemplate public flashLoanTemplate;

    function setUp() public {
        mainnetFork = vm.createFork(RPC_URL);
        vm.selectFork(mainnetFork);

        flashLoanTemplate = new FlashLoanTemplate();
    }

    function testFlashLoan() public {
        flashLoanTemplate.initiateAttack();
    }
}
