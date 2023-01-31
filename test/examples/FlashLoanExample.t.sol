pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/flashloan/examples/FlashLoanExample.sol";
import "../../src/flashloan/examples/MultiProviderFlashLoanExample.sol";

contract FlashLoanExampleTest is Test {
    uint256 mainnetFork;
    string RPC_URL = vm.envString("RPC_URL");

    FlashLoanExample public flashLoanExample;
    MultiProviderFlashLoanExample public multiProviderFlashLoanExample;

    function setUp() public {
        mainnetFork = vm.createFork(RPC_URL);
        vm.selectFork(mainnetFork);

        flashLoanExample = new FlashLoanExample();
        multiProviderFlashLoanExample = new MultiProviderFlashLoanExample();
    }

    function testFlashLoan() public {
        flashLoanExample.initiateAttack();
    }

    function testMultiProviderFlashLoan() public {
        multiProviderFlashLoanExample.initiateAttack();
    }
}
