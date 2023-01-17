pragma solidity ^0.8.0;

import "./flashloan/Flashloan.sol";
import "./tokens/Tokens.sol";

import "forge-std/console.sol";

contract FlashLoanTemplate is Flashloan, Tokens {
    function initiateAttack() external {
        // Take flash loan on some token
        deal(EthereumTokens.DAI, address(this), 900000000000000);
        takeFlashLoan(FlashLoanProviders.AAVEV1, address(EthereumTokens.DAI), 1 ether);
    }

    function _executeAttack() internal override {
        // Execute attack and use flash loaned funds here
    }

    function _completeAttack() internal override {
        // Finish attack
        // This function is called after the flash loan is repayed
    }
}
