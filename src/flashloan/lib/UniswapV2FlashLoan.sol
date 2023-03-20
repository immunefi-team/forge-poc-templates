pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";

library UniswapV2FlashLoan {
    /**
     * @dev struct that hold the reference of IUnisawpV2Pair and asset address
     */
    struct Context {
        IUniswapV2Pair uniswapV2Pair;
    }

    bytes4 constant CALLBACK_SELECTOR = 0x10d1e85c; // keccak256(uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data))

    /**
     * @dev Allows a user to take a flash loan from UniswapV2Pair for a given token pair with amounts
     * @param tokens The addresses of the tokens to borrow
     * @param amounts The amounts of the tokens to borrow
     */
    function takeFlashLoan(address[] memory tokens, uint256[] memory amounts) internal {
        require(tokens.length == 2, "UniswapV2Flashloan: Incorrect tokens length");
        require(amounts.length == 2, "UniswapV2Flashloan: Incorrect amounts length");
        Context memory context = context(tokens);

        require(address(context.uniswapV2Pair) != address(0), "UniswapV2Flashloan: Pair contract not found");

        address token0 = IUniswapV2Pair(context.uniswapV2Pair).token0();
        address token1 = IUniswapV2Pair(context.uniswapV2Pair).token1();

        uint256 amount0;
        uint256 amount1;

        (amount0, amount1) = token0 == tokens[0] ? (amounts[0], amounts[1]) : (amounts[1], amounts[0]);

        IUniswapV2Pair(context.uniswapV2Pair).swap(
            // Uniswap V2 requires data be non empty for the flash loan callback to be called
            amount0,
            amount1,
            address(this),
            "immunefi.flashloan.UniswapV2FlashLoan"
        );
    }

    /**
     * @dev Allows a user to take a flash loan from UniswapV2Pair for a given token and amount
     * @dev defaults to using WETH pair
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(address token, uint256 amount) internal {
        address[] memory tokens = new address[](1);
        tokens[0] = token;
        Context memory context = context(tokens);

        require(address(context.uniswapV2Pair) != address(0), "UniswapV2Flashloan: Pair contract not found");

        address token0 = IUniswapV2Pair(context.uniswapV2Pair).token0();
        address token1 = IUniswapV2Pair(context.uniswapV2Pair).token1();

        uint256 amount0;
        uint256 amount1;

        (amount0, amount1) = token0 == token ? (amount, amount1) : (amount0, amount);

        IUniswapV2Pair(context.uniswapV2Pair).swap(
            // Uniswap V2 requires data be non empty for the flash loan callback to be called
            amount0,
            amount1,
            address(this),
            "immunefi.flashloan.UniswapV2FlashLoan"
        );
    }

    /**
     * @dev Pay back the flash loan to UniswapV2Pair contract
     * @param data The data of the flash loan
     */
    function payFlashLoan(bytes calldata data) internal {
        (address sender, uint256 amount0, uint256 amount1, bytes memory params) = unpackData(data);

        uint256 fee;
        address asset;

        if (amount1 > 0) {
            asset = IUniswapV2Pair(msg.sender).token1();
            fee = calcFlashloanFee(amount1);
            IERC20(asset).transfer(msg.sender, amount1 + fee);
        }
        if (amount0 > 0) {
            asset = IUniswapV2Pair(msg.sender).token0();
            fee = calcFlashloanFee(amount0);
            IERC20(asset).transfer(msg.sender, amount0 + fee);
        }
    }

    /**
     * @dev Helper function which returns the on chain context needed to execute a flashloan
     * @dev If a single token is provided, defaults to using WETH pair
     * @param token The address of the token to borrow
     * @return The context of the flashloan
     */
    function context(address[] memory token) internal view returns (Context memory) {
        IUniswapV2Factory uniswapV2Factory;
        IUniswapV2Pair uniswapV2Pair;

        address token0;
        address token1;

        address WETH;
        address USDC;

        address defaultToken;

        if (block.chainid == 1) {
            // Ethereum mainnet
            WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
            USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

            // By default will search for WETH <-> token pair
            // If Flashloan WETH, automatically use WETH <-> USDC pair
            if (token.length == 1) {
                defaultToken = token[0] == WETH ? USDC : WETH;
            }
            uniswapV2Factory = IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
        } else if (block.chainid == 100) {
            // Gnosis mainnet
            WETH = 0x6A023CCd1ff6F2045C3309768eAd9E68F978f6e1;
            USDC = 0xDDAfbb505ad214D7b80b1f830fcCc89B60fb7A83;

            // By default will search for WETH <-> token pair
            // If Flashloan WETH, automatically use WETH <-> USDC pair
            if (token.length == 1) {
                defaultToken = token[0] == WETH ? USDC : WETH;
            }
            uniswapV2Factory = IUniswapV2Factory(0xc35DADB65012eC5796536bD9864eD8773aBc74C4);
        } else {
            revert("UniswapV2Flashloan: Chain not supported");
        }
        if (defaultToken != address(0)) {
            (token0, token1) = defaultToken < token[0] ? (defaultToken, token[0]) : (token[0], defaultToken);
            uniswapV2Pair = IUniswapV2Pair(uniswapV2Factory.getPair(token0, token1));
        } else {
            uniswapV2Pair = IUniswapV2Pair(uniswapV2Factory.getPair(token[0], token[1]));
        }

        return Context(uniswapV2Pair);
    }

    /**
     * @dev Helper function which decodes the flash loan callback data
     * @param data The data of the flash loan
     * @return sender The address of this contract
     * @return amount0 The amount of the asset borrowed
     * @return amount1 The amount of the asset borrowed
     * @return params Additional params associated with the flash loan
     */
    function unpackData(bytes calldata data)
        internal
        pure
        returns (address sender, uint256 amount0, uint256 amount1, bytes memory params)
    {
        (sender, amount0, amount1, params) = abi.decode(data[4:], (address, uint256, uint256, bytes));
        return (sender, amount0, amount1, params);
    }

    /**
     * @dev Helper function which calculate fees
     * @param amount The amount of the asset borrowed
     * @return fee The fee associated with the flash loan
     */
    function calcFlashloanFee(uint256 amount) internal returns (uint256 fee) {
        fee = ((amount * 3) / 997) + 1;
    }
}

interface IUniswapV2Pair {
    function swap(uint256 amount0Out, uint256 amount1Out, address to, bytes calldata data) external;
    function token0() external view returns (address);
    function token1() external view returns (address);
}

interface IUniswapV2Factory {
    function getPair(address token0, address token1) external view returns (address);
}
