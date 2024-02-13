## Vulnerability Type
This template is designed for developing attack proof of concepts (PoCs) that exploit vulnerabilities which rely on data returned by an oracle. Please note: When crafting a PoC which manipulates oracle data, the oracle manipulation must be achievable independently from the attack. Oracle mocking allows for easier testing of situations where the mocked oracle data is known to be achievable by other means. If the data returned is not achievable in normal operation of the Oracle, the vulnerability is not considered valid. The template supports manipulation of the following oracles:

<details>
  <summary>

### Ethereum
  </summary>

| Network | Oracle Provider | Library |
| ------- | --------------- | ------- |
| Ethereum | Chainlink | [Chainlink](./lib/MockChainLink.sol) |
| Ethereum | Band Oracle | [Band](./lib/MockBand.sol) |
| Ethereum | Pyth Oracle | [Pyth](./lib/MockPyth.sol) |

</details>

## Usage
The following attack contract demonstrates simple oracle data manipulation:
* [OracleManipulationExample](./examples/MockOracleExample.sol)

Extend the `MockOracleExample` contract:
```Solidity
contract Attack is MockOracleExample { }
```

Please be aware that various oracles adhere to distinct `mockOracleData` structures and types.

To identify the specific naming parameters required, examine the library code. For instance, within [Pyth](./lib/MockPyth.sol), there exists a `PriceFeeds` library that contains all the `bytes32` quotes for the pair.

For guidance on how to import and utilize the libraries, refer to the example provided below.

```Solidity
    import "../lib/MockPyth.sol";
    import "../lib/MockChainLink.sol";
    import "../lib/MockBand.sol";

    function initiateAttack() external {
        //1. PYTH ORACLE
        MockPyth.mockOracleData(PriceFeeds.Crypto_BNB_USD, 1337);

        //2. CHAINLINK ORACLE
        MockChainLink.mockOracleData(EthereumTokens.LINK, Fiat.USD, 1337);

        //3. BAND ORACLE
        MockBand.mockOracleData("STRK", "USD", 1337);
        _executeAttack();
    }
```