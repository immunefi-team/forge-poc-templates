pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../../../src/oracle/examples/MockOracleExample.sol";

contract MockOracleExampleTest is Test {
    MockOracleExample public mockOracleExample;

    function setUp() public {
        vm.createSelectFork("eth");
        mockOracleExample = new MockOracleExample();
    }

    function testAttack() public {
        mockOracleExample.initiateAttack();
    }
}
