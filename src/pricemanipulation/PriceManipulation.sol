pragma solidity ^0.8.0;

import "../reentrancy/Reentrancy.sol";
import "./PriceManipulationProvider.sol";

import "forge-std/console.sol";

abstract contract PriceManipulation is Reentrancy {
    using PriceManipulationProvider for PriceManipulationProviders;

    /**
     * @dev Price oracle provider call stack
     */
    PriceManipulationProviders[] internal _pmps;

    function manipulatePrice(PriceManipulationProviders pmp, address token0, address token1, uint256 amount0, uint256 amount1) internal virtual {
        manipulatePrice(pmp, IERC20(token0), IERC20(token1), amount0, amount1);
    }

    function manipulatePrice(PriceManipulationProviders pmp, IERC20 token0, IERC20 token1, uint256 amount0, uint256 amount1) internal virtual {
        _pmps.push(pmp);
        pmp.manipulatePrice(token0, token1, amount0, amount1);
        _pmps.pop();
    }

    /**
     * @dev Returns the top most provider from the call stack
     * @return pmp The current flash loan provider context
     */
    function currentPriceOracleProvider() internal view returns (PriceManipulationProviders pmp) {
        // console.log("PMP");
        // require(_pmps.length > 0, "FlashLoan: No current flash loan provider");
        if (_pmps.length > 0) {
            return _pmps[_pmps.length - 1];
        }
        return PriceManipulationProviders.NONE;
    }

    /**
     * @dev Executes the attack logic for the price manipulation
     */
    function _executeAttack() internal virtual override;

    /**
     * @dev Completes the attack logic
     */
    function _completeAttack() internal virtual override;

    /**
     * @dev Function run when target contract makes external call back to attack contract
     */
    function _reentrancyCallback() internal virtual override {
        if (_pmps.length > 0) {
            PriceManipulationProviders pmp = currentPriceOracleProvider();
            if (pmp.callbackFunctionSelector() == "" || pmp.callbackFunctionSelector() == bytes4(msg.data[:4])) {
                _executeAttack();
                _completeAttack();
            }
        }
    }
}
