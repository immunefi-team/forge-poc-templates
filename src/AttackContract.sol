// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@immunefi/src/PoC.sol";
import "@immunefi/src/pricemanipulation/PriceManipulation.sol";

contract AttackContract is PriceManipulation, PoC {
    function initializeAttack() public {
        console.log("\n>>> Initialize attack");
        // Manipulate price of provided token pair
        // See supported oracle providers here: https://github.com/immunefi-team/forge-poc-templates/tree/main/src/pricemanipulation/lib
        manipulatePrice(
            PriceManipulationProviders.CURVE, EthereumTokens.ETH, EthereumTokens.stETH, 40000 ether, 40000 ether
        );
    }

    function _executeAttack() internal override {
        console.log("\n>>> Execute attack");
        if (currentPriceOracleProvider() == PriceManipulationProviders.CURVE) {
            // Use manipulated price
            // For an example see: https://github.com/immunefi-team/forge-poc-templates/blob/main/src/pricemanipulation/examples/PriceManipulationExample.sol
            _completeAttack();
        }
    }

    function _completeAttack() internal override {
        console.log("\n>>> Complete attack");
    }
}
