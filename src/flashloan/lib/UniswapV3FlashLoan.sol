pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";

library UniswapV3FlashLoan {
    /**
     * @dev struct that hold the reference of IUnisawpV2Pair and asset address
     */
    struct Context {
        IUniswapV3Pool uniswapV3Pool;
        address asset;
    }

    /**
     * @dev struct that hold the reference of fee and tickspacing in the factory contract
     */
    struct FeesTickSpacing {
        uint24 fee;
        int24 tickSpacing;
    }

    bytes4 constant CALLBACK_SELECTOR = 0xe9cbafb0; // keccak256(uniswapV3FlashCallback(uint256,uint256,bytes))

    /**
     * @dev Allows a user to take a flash loan from UniswapV3Pair for a given Pair and amount
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(address token, uint256 amount) internal {
        Context memory context = context(address(0), token, amount);

        require(address(context.uniswapV3Pool) != address(0), "UniswapV3Flashloan: Pair contract not found");

        address token0 = IUniswapV3Pool(context.uniswapV3Pool).token0();
        address token1 = IUniswapV3Pool(context.uniswapV3Pool).token1();

        uint256 amount0;
        uint256 amount1;

        (amount0, amount1) = token0 == context.asset ? (amount, amount1) : (amount0, amount);

        IUniswapV3Pool(context.uniswapV3Pool).flash(
            // Uniswap V3 requires data be non empty for the flash loan callback to be called
            address(this),
            amount0,
            amount1,
            "immunefi.flashloan.UniswapV3FlashLoan"
        );
    }

    /**
     * @dev Allows a user to take a flash loan from UniswapV3Pair for a given Pair and amount
     * @param pair The address of the pair contract, use address(0) if pair is unknown
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(address pair, address token, uint256 amount) internal {
        Context memory context = context(pair, token, amount);

        require(address(context.uniswapV3Pool) != address(0), "UniswapV3Flashloan: Pair contract not found");

        address token0 = IUniswapV3Pool(context.uniswapV3Pool).token0();
        address token1 = IUniswapV3Pool(context.uniswapV3Pool).token1();

        uint256 amount0;
        uint256 amount1;

        (amount0, amount1) = token0 == context.asset ? (amount, amount1) : (amount0, amount);

        IUniswapV3Pool(context.uniswapV3Pool).flash(
            address(this), amount0, amount1, "immunefi.flashloan.UniswapV3FlashLoan"
        );
    }

    /**
     * @dev Pay back the flash loan to UniswapV3Pair contract
     * @param data The data of the flash loan
     */
    function payFlashLoan(bytes calldata data) internal {
        (uint256 fees0, uint256 fees1, bytes memory params) = unpackData(data);

        address asset;
        uint256 amount;

        if (fees1 > 0) {
            asset = IUniswapV3Pool(msg.sender).token1();
            amount = calcAmount(fees1);
            IERC20(asset).transfer(msg.sender, amount + fees1);
        }
        if (fees0 > 0) {
            asset = IUniswapV3Pool(msg.sender).token0();
            amount = calcAmount(fees0);
            IERC20(asset).transfer(msg.sender, amount + fees0);
        }
    }

    /**
     * @dev Helper function which returns the on chain context needed to execute a flashloan
     * @param pair The address of pair contract, use address(0) if pair is unkown
     * @param token The address of the token to borrow
     * @return The context of the flashloan
     */
    function context(address pair, address token, uint256 amount) internal view returns (Context memory) {
        IUniswapV3Factory uniswapV3Factory;
        IUniswapV3Pool uniswapV3Pool;

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
            defaultToken = token == WETH ? USDC : WETH;
            uniswapV3Factory = IUniswapV3Factory(0x1F98431c8aD98523631AE4a59f267346ea31F984);
        } else {
            revert("UniswapV3Flashloan: Chain not supported");
        }
        if (pair == address(0)) {
            (token0, token1) = defaultToken < token ? (defaultToken, token) : (token, defaultToken);

            uniswapV3Pool = IUniswapV3Pool(getPair(uniswapV3Factory, token0, token1, amount, token));
        } else {
            uniswapV3Pool = IUniswapV3Pool(pair);
        }

        return Context(uniswapV3Pool, token);
    }

    /**
     * @dev Helper function which decodes the flash loan callback data
     * @param data The data of the flash loan
     * @return fee0 The fee of the asset 0
     * @return fee1 The fee of the asset 1
     * @return params Additional params associated with the flash loan
     */
    function unpackData(bytes calldata data) internal pure returns (uint256 fee0, uint256 fee1, bytes memory params) {
        (fee0, fee1, params) = abi.decode(data[4:], (uint256, uint256, bytes));
        return (fee0, fee1, params);
    }

    /**
     * @dev Helper function which calculates the amount based on the fees from the callback
     * @param fees The fees from the flashloan
     * @return amount The flashloan amount
     */
    function calcAmount(uint256 fees) internal view returns (uint256 amount) {
        uint256 basisPoints = 1e6;

        uint256 fee = uint256(IUniswapV3Pool(msg.sender).fee());

        amount = (fees * basisPoints) / fee + 1;
        return amount;
    }

    /**
     * @dev Helper function which saved the current fees that was available in the factory
     * @return fees a struct of fees that was available in the factory
     */
    function getFees() internal pure returns (FeesTickSpacing[] memory) {
        FeesTickSpacing[] memory fees = new FeesTickSpacing[](4);
        fees[0] = FeesTickSpacing(100, 1);
        fees[1] = FeesTickSpacing(500, 10);
        fees[2] = FeesTickSpacing(3000, 60);
        fees[3] = FeesTickSpacing(10000, 200);
        return fees;
    }

    /**
     * @dev Helper function to search the pair address that was available in the factory contract
     * @param factory The address of the factory contract
     * @param token0 The address of token0
     * @param token1 The address of token1
     * @param amount The amount of token
     * @param token The address of the flashloaned token
     * @return pair The address of the pair contract
     */
    function getPair(IUniswapV3Factory factory, address token0, address token1, uint256 amount, address token)
        internal
        view
        returns (address pair)
    {
        FeesTickSpacing[] memory _fees = getFees();

        for (uint256 i; i < _fees.length; i++) {
            pair = factory.getPool(token0, token1, _fees[i].fee);
            if (pair != address(0) && IERC20(token).balanceOf(pair) >= amount) {
                return pair;
            }
        }
        revert("UniswapV3Flashloan: Pair not found/amount to big");
    }
}

interface IUniswapV3Pool {
    function flash(address recipient, uint256 amount0Out, uint256 amount1Out, bytes calldata data) external;
    function token0() external view returns (address);
    function token1() external view returns (address);
    function fee() external view returns (uint24);
}

interface IUniswapV3Factory {
    function getPool(address token0, address token1, uint24 fee) external view returns (address);
}
