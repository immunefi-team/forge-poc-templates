// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@immunefi/src/PoC.sol";
import "@immunefi/src/flashloan/FlashLoan.sol";

contract AttackContract is FlashLoan, PoC {
    function initializeAttack() public {
        console.log("\n>>> Initalize attack");
        takeFlashLoan(FlashLoanProviders.MAKERDAO, EthereumTokens.DAI, 1 * 10 ** 18);
    }

    function _executeAttack() internal override {
        if (currentFlashLoanProvider() == FlashLoanProviders.MAKERDAO) {
            console.log("Use flash loaned funds");
            EthereumTokens.DAI.transfer(address(0xdead), 1 * 10 ** 18);
        }
    }
    
    function _completeAttack() internal override {
        console.log("\n>>> Complete attack");
    }
}
