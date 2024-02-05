pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "../../../src/oracle/examples/MockOracleExample.sol";

contract MockOracleExampleTest is Test {
    MockOracleExample public mockOracleExample;

    function setUp() public {
        vm.createSelectFork("https://rpc.ankr.com/eth");


        // vm.mockCall(0x4305FB66699C3B2702D4d05CF36551390A4c69C6, hex"96834ad3", abi.encode(1));

        mockOracleExample = new MockOracleExample();
    }

    function testAttack() public {
        mockOracleExample.initiateAttack();
    }
}
