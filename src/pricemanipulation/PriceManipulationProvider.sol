pragma solidity ^0.8.0;

import "../tokens/Tokens.sol";
import {CurvePriceManipulation} from "./lib/CurvePriceManipulation.sol";

enum PriceManipulationProviders {
    NONE,
    CURVE
}

library PriceManipulationProvider {
    function manipulatePrice(PriceManipulationProviders pmp, IERC20 token0, IERC20 token1, uint256 amount0, uint256 amount1) internal {
        if (pmp == PriceManipulationProviders.CURVE) {
            CurvePriceManipulation.manipulatePoolPrice(token0, token1, amount0, amount1);
        } else {
            revert("PriceManipulationProvider: Provider doesn't support single token flash loans");
        }
    }

    /**
     * @dev Gets the bytes4 function selector for the intended callback
     * @param pmp The price oracle provider to get the callback selector of
     */
    function callbackFunctionSelector(PriceManipulationProviders pmp) internal pure returns (bytes4) {
        // if (pmp == PriceManipulationProviders.CURVE) {
        //     return CurvePriceManipulation.CALLBACK_SELECTOR;
        // }
    }

    /**
     * @dev Gets the bytes32 return data for the intended callback
     * @param pmp The price oracle provider to get the return data of
     */
    function returnData(PriceManipulationProviders pmp) internal pure returns (bytes memory) {
        // if (pmp == PriceManipulationProviders.CURVE) {
        //     return CurvePriceManipulation.RETURN_DATA;
        // }
    }
}
