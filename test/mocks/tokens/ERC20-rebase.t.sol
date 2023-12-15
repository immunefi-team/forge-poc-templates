pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/interfaces/IERC20.sol";
import {ERC20Rebase} from "../../../src/mocks/tokens/ERC20-rebase.sol";

contract ERC20RebasingTest is Test {
    IERC20 public rebasingToken;
    uint256 immutable initialSupply = 1000000000;
    uint256 rebasingInterval = 1 minutes;
    uint256 rebasingAmt = 5;

    address alice = vm.addr(1);
    address bob = vm.addr(2);

    function setUp() public {
        rebasingToken = new ERC20Rebase("BoolToken", "Btoken", 18, initialSupply, rebasingInterval, rebasingAmt);
        assertEq(rebasingToken.balanceOf(address(this)), initialSupply);
    }

    function testRebasingTransfer() public {
        uint256 transferAmt = 100;
        assertEq(rebasingToken.totalSupply(), initialSupply);

        uint256 balBefore = rebasingToken.balanceOf(address(this));
        uint256 userBalBefore = rebasingToken.balanceOf(address(alice));

        vm.warp(block.timestamp + rebasingInterval);

        rebasingToken.transfer(address(alice), transferAmt);
        uint256 balAfter = rebasingToken.balanceOf(address(this));
        uint256 userBalAfter = rebasingToken.balanceOf(address(alice));

        assertEq(rebasingToken.totalSupply(), initialSupply + rebasingAmt);

        assertEq(balAfter, balBefore - transferAmt + rebasingAmt);
        assertEq(userBalAfter, userBalBefore + transferAmt);
    }
}
