pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import {returnBomb} from "../../../src/mocks/malicious/returnBomb.sol";

contract returnBombTest is Test {
    returnBomb public attacker;

    function setUp() public {
        attacker = new returnBomb();
    }

    function testReturnBomb() public {
        (bool success, bytes memory returnData) = address(attacker).call{gas: 3397}("");
        assertEq(success, false);
    }
}
