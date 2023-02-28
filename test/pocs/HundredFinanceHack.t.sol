pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../pocs/HundredFinanceHack.sol";

contract HundredFinanceHackTest is Test {
    uint256 mainnetFork;

    HundredFinanceHack public hundredFinanceHack;

    function setUp() public {
        hundredFinanceHack = new HundredFinanceHack();
    }

    function testFlashLoan() public {
        hundredFinanceHack.initiateAttack();
    }
}
