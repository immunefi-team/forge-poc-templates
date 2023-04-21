pragma solidity ^0.8.0;

import "../FlashLoan.sol";
import "../../tokens/Tokens.sol";

import "forge-std/console.sol";

contract FlashLoanExample is FlashLoan, Tokens {
    FlashLoanProviders internal _flp;

    function initiateAttack(FlashLoanProviders flp) external {
        _flp = flp;
        uint256 fee;
        if (flp == FlashLoanProviders.AAVEV1 || flp == FlashLoanProviders.AAVEV2 || flp == FlashLoanProviders.AAVEV3) {
            fee = 900000000000000;
        } else if (flp == FlashLoanProviders.UNISWAPV2) {
            fee = 3009027081243732;
        } else if (flp == FlashLoanProviders.UNISWAPV3) {
            fee = 500000000000000 + 1;
        }
        deal(EthereumTokens.DAI, address(this), fee);
        console.log("DAI BALANCE BEFORE:", EthereumTokens.DAI.balanceOf(address(this)));
        takeFlashLoan(flp, address(EthereumTokens.DAI), 1 ether);
    }

    function _executeAttack() internal override {
        console.log("DAI BALANCE DURING:", EthereumTokens.DAI.balanceOf(address(this)));
        if (currentFlashLoanProvider() == FlashLoanProviders.AAVEV1) {
            // Execute attack with funds from AAVEV1
        }
    }

    function _completeAttack() internal override {
        console.log("DAI BALANCE AFTER :", EthereumTokens.DAI.balanceOf(address(this)));
    }
}
