pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import {returnBomb} from "../../../src/mocks/malicious/returnBomb.sol";

contract returnBombTest is Test {
    returnBomb public attacker;

    function setUp() public {
        attacker = new returnBomb();
    }

    function callSomething() public {
        uint256 innerGasVal = gasleft() / 2;
        (bool success, bytes memory returnData) = address(attacker).call{gas: innerGasVal}("");
        console.log("returnBomb Innercall success: ", success);
    }

    function testReturnBombRevert() public {
        vm.expectRevert();
        this.callSomething{gas: 3000}();
    }

    function testReturnBombNotRevert() public {
        this.callSomething{gas: 10000}();
    }

    function testSetters() public {
        attacker.setReturnDataSize(50000);
        assertEq(attacker.returnDataSize(), 50000);
    }
}
