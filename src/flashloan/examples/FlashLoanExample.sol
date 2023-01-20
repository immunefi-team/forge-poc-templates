pragma solidity ^0.8.0;

import "../FlashLoan.sol";
import "../../tokens/Tokens.sol";

import "forge-std/console.sol";

contract FlashLoanExample is FlashLoan, Tokens {
    function initiateAttack() external {
        deal(EthereumTokens.DAI, address(this), 900000000000000);
        console.log("DAI BALANCE BEFORE:", EthereumTokens.DAI.balanceOf(address(this)));
        takeFlashLoan(FlashLoanProviders.AAVEV1, address(EthereumTokens.DAI), 1 ether);
        takeFlashLoan(FlashLoanProviders.BALANCER, address(EthereumTokens.DAI), 1 ether);
        takeFlashLoan(FlashLoanProviders.EULER, address(EthereumTokens.DAI), 1 ether);
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
