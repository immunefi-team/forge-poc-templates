pragma solidity ^0.8.0;

import "forge-std/console.sol";

import "../../tokens/Tokens.sol";

import "../lib/MockPyth.sol";
import "../lib/MockChainLink.sol";

contract MockOracleExample {
    function initiateAttack() external {
        //1. PYTH ORACLE
        MockPyth.mockOracleData(PriceFeeds.Crypto_BNB_USD, 1337);
        //2. CHAINLINK ORACLE
        MockChainLink.mockOracleData(EthereumTokens.LINK, Fiat.USD, 1337); // LINK/USD

        _executeAttack();
    }

    function _executeAttack() internal {
        //1. PYTH ORACLE
        PythUpgradable pyth = PythUpgradable(0x4305FB66699C3B2702D4d05CF36551390A4c69C6);
        PythUpgradable.Price memory p = pyth.getPriceUnsafe(PriceFeeds.Crypto_BNB_USD);
        console.logInt(p.price);
        _completeAttack();

        //2. CHAINLINK ORACLE
        FeedRegistryInterface chainlinkRegistry = FeedRegistryInterface(0x47Fb2585D2C56Fe188D0E6ec628a38b74fCeeeDf);
        (, int256 answer,,,) = chainlinkRegistry.latestRoundData(EthereumTokens.LINK, Fiat.USD);
        console.logInt(answer);
        _completeAttack();
    }

    function _completeAttack() internal {}
}