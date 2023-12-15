pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import {gasExhaust} from "../../../src/mocks/malicious/gasExhaust.sol";

contract gasExhaustTest is Test {
    gasExhaust public attacker;

    function setUp() public {
        attacker = new gasExhaust();
    }

    function testGasExhaustSuccess() public {
        attacker.setGasConsumeLimit(6000);
        (bool success, bytes memory returnData) = address(attacker).call{gas: 25000}("");
        assertEq(success, true);
    }

    function testGasExhaustFail() public {
        attacker.setGasConsumeLimit(100);
        (bool success, bytes memory returnData) = address(attacker).call{gas: 25000}("");
        assertEq(success, false);
    }
}
