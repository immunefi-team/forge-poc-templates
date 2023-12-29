pragma solidity ^0.8.0;

import {ChainlinkOracle} from "./lib/ChainlinkOracle.sol";

enum OracleProviders {
    NONE,
    CHAINLINK
}

library OracleProvider {
    /**
     * @dev Returns the name of the specified oracle provider.
     * @param op The oracle provider enumeration value.
     * @return A string representing the name of the oracle provider.
     */
    function name(OracleProviders op) internal pure returns (string memory) {
        if (op == OracleProviders.CHAINLINK) {
            return "Chainlink";
        } else {
            return "None";
        }
    }

    /**
     * @dev Mocks oracle data for the specified OracleProvider. This function is primarily used for testing.
     * @param op The oracle provider to mock data for.
     * @param data The mock data to be used.
     */
    function mockOracleData(OracleProviders op, bytes memory data) internal {
        if (op == OracleProviders.CHAINLINK) {
            ChainlinkOracle.mockOracleData(data);
        } else {
            revert("OracleProvider: Provider is not supported");
        }
    }
}
