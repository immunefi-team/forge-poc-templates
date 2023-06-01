// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../pocs/DFXFinanceBugfixReview.sol";

contract DFXFinanceBugfixReviewTest is Test {
    DFXFinanceBugfixReview attackContract;

    function setUp() public {
        vm.createSelectFork("https://rpc.ankr.com/polygon", 42064500);

        attackContract = new DFXFinanceBugfixReview();
    }

    function testAttack() public {
        attackContract.initiateAttack();
    }
}
