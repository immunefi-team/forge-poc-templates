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

    /**
     * @dev Manipulates the price of a given token pair by calling the manipulatePrice function on a PriceManipulationProviders contract.
     * @param pmp The PriceManipulationProviders contract instance.
     * @param token0 The address of the first token to manipulate.
     * @param token1 The address of the second token to manipulate.
     * @param amount0 The amount of the first token.
     * @param amount1 The amount of the second token.
     */
    function manipulatePrice(
        PriceManipulationProviders pmp,
        address token0,
        address token1,
        uint256 amount0,
        uint256 amount1
    ) internal virtual {
        manipulatePrice(pmp, IERC20(token0), IERC20(token1), amount0, amount1);
    }

    /**
     * @dev Manipulates the price of a given token pair by calling the manipulatePrice function on a PriceManipulationProviders contract.
     * @param pmp The PriceManipulationProviders contract instance.
     * @param token0 The IERC20 contract instance of the first token to manipulate.
     * @param token1 The IERC20 contract instance of the second token to manipulate.
     * @param amount0 The amount of the first token.
     * @param amount1 The amount of the second token.
     */
    function manipulatePrice(
        PriceManipulationProviders pmp,
        IERC20 token0,
        IERC20 token1,
        uint256 amount0,
        uint256 amount1
    ) internal virtual {
        _pmps.push(pmp);
        pmp.manipulatePrice(token0, token1, amount0, amount1);
        _pmps.pop();
    }

    /**
     * @dev Returns the top most provider from the call stack
     * @return pmp The current flash loan provider context
     */
    function currentPriceOracleProvider() internal view returns (PriceManipulationProviders pmp) {
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
                bytes memory returnData = pmp.returnData();
                assembly {
                    let len := mload(returnData)
                    return(add(returnData, 0x20), len)
                }
            }
        }
    }
}
