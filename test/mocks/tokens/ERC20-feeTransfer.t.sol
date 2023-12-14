pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/interfaces/IERC20.sol";
import {ERC20FeeTransfer} from "../../../src/mocks/tokens/ERC20-feeTransfer.sol";

contract ERC20FeeTest is Test {
    IERC20 public feeToken;
    uint256 immutable initialSupply = 1000000000;
    uint8 immutable fee = 5;

    address alice = vm.addr(1);
    address bob = vm.addr(2);

    function setUp() public {
        feeToken = new ERC20FeeTransfer("FeeToken", "Ftoken", 18, initialSupply, fee);
        assertEq(feeToken.balanceOf(address(this)), initialSupply);
    }

    function testFeeOnTransfer() public {
        uint256 amt = 100;

        uint256 balBefore = feeToken.balanceOf(address(this));
        uint256 userBalBefore = feeToken.balanceOf(address(alice));
        feeToken.transfer(address(alice), amt);
        uint256 balAfter = feeToken.balanceOf(address(this));
        uint256 userBalAfter = feeToken.balanceOf(address(alice));

        assertEq(balAfter, balBefore - amt);
        assertEq(userBalAfter, userBalBefore + amt - fee);
    }
}
