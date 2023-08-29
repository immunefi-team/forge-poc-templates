// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@immunefi/src/PoC.sol";
import "@immunefi/src/pricemanipulation/PriceManipulation.sol";

contract AttackContract is PriceManipulation, PoC {
    function initializeAttack() public {
        console.log("\n>>> Initialize attack");
        manipulatePrice(
            PriceManipulationProviders.CURVE,
            EthereumTokens.ETH,
            EthereumTokens.stETH,
            40000 ether,
            40000 ether
        );
    }

    function _executeAttack() internal override {
        console.log("\n>>> Execute attack");
        _completeAttack();
    }
    
    function _completeAttack() internal override {
        console.log("\n>>> Complete attack");
    }
}
