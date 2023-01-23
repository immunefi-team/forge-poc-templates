pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library UniswapV2Flashloan{
    /**
     * @dev struct that hold the reference of IAAVEV1LendingPool and address core
     */
    struct Context {
        IUniswapV2Pair UniswapV2Pair;
        address asset;
    }

    bytes4 constant CALLBACK_SELECTOR = 0x10d1e85c; // keccak256(uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data))

    /**
     * @dev Allows a user to take a flash loan from UniswapV2Pair for a given Pair and amount
     * @param pair The address of the pair contract, use address(0) if pair is unkown
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(address pair, address token, uint256 amount) internal {

        Context memory context = context(pair, token);

        require(address(context.UniswapV2Pair) != address(0), "UniswapV2Flashloan: Pair contract not found");

        address token0 = IUniswapV2Pair(context.UniswapV2Pair).token0();
        address token1 = IUniswapV2Pair(context.UniswapV2Pair).token1();

        uint256 amount0;
        uint256 amount1;

        (amount0, amount1) = token0 == context.asset? (amount,) : (,amount);

        IUniswapV2Pair(context.UniswapV2Pair).swap(amount0, amount1, address(this), "");
    }

    /**
     * @dev Pay back the flash loan to UniswapV2Pair contract
     * @param data The data of the flash loan
     */
    function payFlashLoan(bytes calldata data) internal {
        (address sender, uint256 amount0, uint256 amount1, bytes memory params) = unpackData(data);

        uint256 fee;
        address asset;

        if (amount0 == 0) {
            asset = IUniswapV2Pair(msg.sender).token1();
            fee = calcFlashloanFee(amount1);
            IERC20(asset).transfer(msg.sender, amount1 + fee);
        }else {
            asset = IUniswapV2Pair(msg.sender).token0();
            fee = calcFlashloanFee(amount0);
            IERC20(asset).transfer(msg.sender, amount0 + fee);
        }
    }

    /**
     * @dev Helper function which returns the on chain context needed to execute a flashloan
     * @param pair The address of pair contract, use address(0) if pair is unkown
     * @param token The address of the token to borrow
     * @return The context of the flashloan
     */
    function context(address pair, address token) internal returns (Context memory) {
        IUniswapV2Factory UniswapV2Factory;

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
            defaultToken = token == WETH? USDC : WETH; 
            UniswapV2Factory = IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f);
        } else {
            revert("AAVEV1FlashLoan: Chain not supported");
        }

        if (pair == address(0)) {
            (token0, token1) = defaultToken < token? (defaultToken, token) : (token, defaultToken);
            IUniswapV2Pair pair = IUniswapV2Pair(UniswapV2Factory.getPair(token0, token1));
        }else {
            pair = IUniswapV2Pair(pair);
        }

        return Context(pair, token);
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
    function calcFlashloanFee(uint256 amount)internal returns(uint256 fee) {
        fee = ((amount * 1000) / 997) + 1;
    }
}

interface IUniswapV2Pair {
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
}

interface IUniswapV2Factory {
    function getPair(address token0, address token1) external returns(address);
    function token0()external view returns(address);
    function token1()external view returns(address);
}