pragma solidity ^0.8.0;

import "../FlashLoan.sol";
import "../../tokens/Tokens.sol";

import "forge-std/console.sol";

contract FlashLoanExample is FlashLoan, Tokens {
    function initiateAttack() external {
        uint256 aaveV1Fee = 900000000000000; // Fee on 1 ether
        uint256 aaveV3Fee = 900000000000000; // Fee on 1 ether
        uint256 uniswapFee = 3009027081243732; // Fee on 1 ether
        deal(EthereumTokens.DAI, address(this), aaveV1Fee + aaveV3Fee + uniswapFee);
        console.log("DAI BALANCE BEFORE:", EthereumTokens.DAI.balanceOf(address(this)));
        takeFlashLoan(FlashLoanProviders.AAVEV1, address(EthereumTokens.DAI), 1 ether);
        takeFlashLoan(FlashLoanProviders.AAVEV3, address(EthereumTokens.DAI), 1 ether);
        takeFlashLoan(FlashLoanProviders.BALANCER, address(EthereumTokens.DAI), 1 ether);
        takeFlashLoan(FlashLoanProviders.EULER, address(EthereumTokens.DAI), 1 ether);
        takeFlashLoan(FlashLoanProviders.MAKERDAO, address(EthereumTokens.DAI), 1 ether);
        takeFlashLoan(FlashLoanProviders.UNISWAPV2, address(EthereumTokens.DAI), 1 ether);
    }

    function _executeAttack() internal override {
        console.log("DAI BALANCE DURING:", EthereumTokens.DAI.balanceOf(address(this)));
        if (currentProvider() == FlashLoanProviders.AAVEV1) {
            // Execute attack with funds from AAVEV1
        }
    }

    function _completeAttack() internal override {
        console.log("DAI BALANCE AFTER :", EthereumTokens.DAI.balanceOf(address(this)));
    }
}
