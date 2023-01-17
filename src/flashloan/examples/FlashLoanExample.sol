pragma solidity ^0.8.0;

import "../Flashloan.sol";
import "../../tokens/Tokens.sol";

import "forge-std/console.sol";

contract FlashLoanExample is Flashloan, Tokens {
    function initiateAttack() external {
        deal(EthereumTokens.DAI, address(this), 1 ether);
        console.log("DAI BALANCE BEFORE:", EthereumTokens.DAI.balanceOf(address(this)));
        takeFlashLoan(FlashLoanProviders.AAVE, address(EthereumTokens.DAI), 1 ether);
    }

    function _executeAttack() internal override {
        console.log("DAI BALANCE DURING:", EthereumTokens.DAI.balanceOf(address(this)));
    }

    function _completeAttack() internal override {
        console.log("DAI BALANCE AFTER :", EthereumTokens.DAI.balanceOf(address(this)));
    }
}
