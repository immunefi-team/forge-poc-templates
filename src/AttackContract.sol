// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@immunefi/src/PoC.sol";
import "@immunefi/src/flashloan/FlashLoan.sol";

contract AttackContract is FlashLoan, PoC {
    IERC20[] tokens;

    function initializeAttack() public {
        console.log("\n>>> Initalize attack");
        // Flash loan funds from provider
        // See available providers: https://github.com/immunefi-team/forge-poc-templates/tree/main/src/flashloan/lib
        takeFlashLoan(FlashLoanProviders.MAKERDAO, EthereumTokens.DAI, 1000000 * 10 ** 18);
    }

    function _executeAttack() internal override {
        if (currentFlashLoanProvider() == FlashLoanProviders.MAKERDAO) {
            // Do something with flash loaned funds
            tokens.push(EthereumTokens.DAI);
            snapshotAndPrint(address(this), tokens);
        }
    }
    
    function _completeAttack() internal override {
        console.log("\n>>> Complete attack");
    }
}
