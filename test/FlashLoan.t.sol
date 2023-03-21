pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FlashLoanTemplate.sol";

contract FlashLoanTest is Test {
    uint256 mainnetFork;

    FlashLoanTemplate public flashLoanTemplate;

    function setUp() public {
        mainnetFork = vm.createFork("eth");
        vm.selectFork(mainnetFork);

        flashLoanTemplate = new FlashLoanTemplate();
    }

    function testFlashLoan() public {
        flashLoanTemplate.initiateAttack();
    }
}
