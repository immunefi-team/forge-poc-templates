pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/interfaces/IERC20.sol";
import {ERC20Bool} from "../../../src/mocks/tokens/ERC20-bool.sol";

contract ERC20BoolTest is Test {
    IERC20 public boolToken;
    uint256 immutable initialSupply = 1000000000;

    address alice = vm.addr(1);
    address bob = vm.addr(2);

    function setUp() public {
        boolToken = new ERC20Bool("BoolToken", "Btoken", 18, initialSupply);
        assertEq(boolToken.balanceOf(address(this)), initialSupply);
    }

    function testBoolTokenTransfer() public {
        assertEq(boolToken.balanceOf(alice), 0);

        bool retVal = boolToken.transfer(alice, 100);
        assertEq(retVal, true);

        assertEq(boolToken.balanceOf(alice), 100);
        assertEq(boolToken.balanceOf(address(this)), initialSupply - 100);
    }

    function testBoolTokenTransferFail() public {
        assertEq(boolToken.balanceOf(alice), 0);

        vm.startPrank(alice);
        bool retVal = boolToken.transfer(bob, 100);
        assertEq(retVal, false);

        assertEq(boolToken.balanceOf(bob), 0);
    }
}
