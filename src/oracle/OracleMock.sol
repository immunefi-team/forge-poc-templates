pragma solidity ^0.8.0;

import "./OracleProvider.sol";

import "forge-std/console.sol";

abstract contract OracleMock {
    using OracleProvider for OracleProviders;

    /**
     * @dev Stack of oracle providers used for managing multiple oracle interactions.
     */
    OracleProviders[] internal _ops;

    /**
     * @dev Mocks oracle data by pushing an oracle provider onto the stack, calling its mockOracleData method,
     * and then popping it from the stack. This simulates the behavior of an oracle provider in a controlled manner.
     * @param op The OracleProvider instance to use for mocking data.
     * @param data The data to be used in the mock call to the oracle.
     */
    function mockOracleData(OracleProviders op, bytes memory data) internal virtual {
        _ops.push(op);
        op.mockOracleData(data);
        _ops.pop();
    }

    /**
     * @dev Retrieves the top-most oracle provider from the stack.
     * @return op The current oracle provider at the top of the stack.
     */
    function currentOracleProvider() internal view returns (OracleProviders op) {
        if (_ops.length > 0) {
            return _ops[_ops.length - 1];
        }
        return OracleProviders.NONE;
    }
}
