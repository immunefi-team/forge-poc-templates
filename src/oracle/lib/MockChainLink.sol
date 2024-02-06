pragma solidity ^0.8.0;

import "../../tokens/Tokens.sol";

/**
 * ChainlinkOracle is a library used to facilitate interactions with Chainlink Oracles.
 * This includes functions to mock oracle data for testing and to retrieve context information
 * specific to the blockchain environment the contract is operating in.
 */
library MockChainLink {
    struct Context {
        EACAggregatorProxy aggregator;
    }

    /**
     * @dev Mocks oracle data for testing purposes. This function allows simulating oracle data
     * within a test environment, enabling the testing of contract interactions with oracles.
     * @param quoteToken The token to quote the price in.
     * @param baseToken The token to get the price of.
     * @param price The price of the base token in terms of the quote token.
     */
    function mockOracleData(IERC20 quoteToken, IERC20 baseToken, uint256 price) internal {
        Context memory context = context();

        // It's likely we can generalize this function to take a token pair to mock the returned price of, but we should provide a generic
        // function which can be used to mock any oracle data, not just price data. This way the Oracle specific library can have their own
        // wrapper function which serializes/deserializes the generic mock oracle data into the appropriate parameters.

        // Code to mock the oracle call...
    }

    /**
     * @dev Retrieves the context information relevant to the current blockchain environment.
     * This function checks the chain ID and returns the corresponding context information,
     * allowing the contract to adapt to different blockchain environments.
     * @return Context The context information for the current blockchain.
     */
    function context() internal view returns (Context memory) {
        EACAggregatorProxy aggregator;

        if (block.chainid == 1) {
            // Ethereum mainnet
            aggregator = EACAggregatorProxy(0x72AFAECF99C9d9C8215fF44C77B94B99C28741e8);
        } else {
            revert("ChainlinkOracle: Chain not supported");
        }

        return Context(aggregator);
    }

    // /**
    //  * @dev Helper function which encode the mock oracle data
    //  * @param param1
    //  * @param param2
    //  * @param param3
    //  */
    // function unpackData(type param1, type param2, type param3)
    //     internal
    //     pure
    //     returns (bytes memory data)
    // {
    //     return abi.encode(param1, param2, param3);
    // }

    // /**
    //  * @dev Helper function which decodes the mock oracle data
    //  * @param data The data of the mock oracle call
    //  */
    // function unpackData(bytes calldata data)
    //     internal
    //     pure
    //     returns (address token0, address token1, uint256 price)
    // {
    //     (token0, token1, price) = abi.decode(data, (address, address, uint256));
    //     return (asset, amount, fee, params);
    // }
}

interface EACAggregatorProxy {
    event AnswerUpdated(int256 indexed current, uint256 indexed roundId, uint256 updatedAt);
    event NewRound(uint256 indexed roundId, address indexed startedBy, uint256 startedAt);
    event OwnershipTransferRequested(address indexed from, address indexed to);
    event OwnershipTransferred(address indexed from, address indexed to);

    function acceptOwnership() external;
    function accessController() external view returns (address);
    function aggregator() external view returns (address);
    function confirmAggregator(address _aggregator) external;
    function decimals() external view returns (uint8);
    function description() external view returns (string memory);
    function getAnswer(uint256 _roundId) external view returns (int256);
    function getRoundData(uint80 _roundId)
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
    function getTimestamp(uint256 _roundId) external view returns (uint256);
    function latestAnswer() external view returns (int256);
    function latestRound() external view returns (uint256);
    function latestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
    function latestTimestamp() external view returns (uint256);
    function owner() external view returns (address);
    function phaseAggregators(uint16) external view returns (address);
    function phaseId() external view returns (uint16);
    function proposeAggregator(address _aggregator) external;
    function proposedAggregator() external view returns (address);
    function proposedGetRoundData(uint80 _roundId)
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
    function proposedLatestRoundData()
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
    function setController(address _accessController) external;
    function transferOwnership(address _to) external;
    function version() external view returns (uint256);
}
