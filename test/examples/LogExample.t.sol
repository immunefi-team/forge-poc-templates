pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/log/examples/LogExample.sol";

contract LogExampleTest is Test {
    uint256 mainnetFork;

    LogExample public logExample;

    function setUp() public {
        mainnetFork = vm.createFork("eth");
        vm.selectFork(mainnetFork);

        logExample = new LogExample();
    }

    function testLog() public {
        logExample.initializeAttack();
    }
}
