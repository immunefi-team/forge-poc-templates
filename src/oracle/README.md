## Vulnerability Type
This template is designed for developing attack proof of concepts (PoCs) that exploit vulnerabilities which rely on data returned by an oracle. Please note: When crafting a PoC which manipulates oracle data, the oracle manipulation must be achievable independently from the attack. Oracle mocking allows for easier testing of situations where the mocked oracle data is known to be achievable by other means. If the data returned is not achievable in normal operation of the Oracle, the vulnerability is not considered valid. The template supports manipulation of the following oracles:

<details>
  <summary>

### Ethereum
  </summary>

| Network | Oracle Provider | Library |
| ------- | --------------- | ------- |
| Ethereum | Chainlink | [Chainlink](./lib/ChainlinkOracle.sol) |

</details>

## Usage
The following attack contract demonstrates simple oracle data manipulation:
* [OracleManipulationExample](./examples/OracleManipulationExample.sol)

Extend the `OracleMock` contract:
```Solidity
contract Attack is OracleMock { }
```

Call mockOracleData(OracleProviders op, bytes memory data) to manipulate the data returned by the oracle. This function will simulate oracle data, which can be used in _executeAttack() to carry out the attack logic.

```Solidity
pragma solidity ^0.8.0;

import "@immunefi/src/oracle/OracleMock.sol";
import { OracleProviders } from "@immunefi/src/oracle/OracleProvider.sol";

contract Attack is PoC, OracleMock {
    // Other contract details...

    function initiateAttack() external {
        // Call initiateAttack to start the attack process
        // This could include setting up necessary state variables
    }

    function _executeAttack() internal override {
        // Example data to be used for the mock oracle
        bytes memory data = abi.encodePacked(/* encoded data here */);

        // Mocking oracle data for the Chainlink provider
        mockOracleData(OracleProviders.CHAINLINK, data);

        // Implement your attack logic here, using the mocked data
        // ...
    }

    function _completeAttack() internal override {
        // Complete the attack logic, clean up, etc.
        // ...
    }
}
```