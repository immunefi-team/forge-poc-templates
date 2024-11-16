pragma solidity ^0.8.13;

import "forge-std-1.9.4/src/Test.sol";
import "../../src/log/examples/LogExample.sol";

contract LogExampleTest is Test {
    LogExample public logExample;

    function setUp() public {
        logExample = new LogExample();
    }

    function testLog() public {
        logExample.initializeAttack();
    }
}
