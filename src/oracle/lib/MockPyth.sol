pragma solidity ^0.8.0;

import "../../tokens/Tokens.sol";
import "forge-std/Vm.sol";

/**
 * ChainlinkOracle is a library used to facilitate interactions with Chainlink Oracles.
 * This includes functions to mock oracle data for testing and to retrieve context information
 * specific to the blockchain environment the contract is operating in.
 */
library MockPyth {
    address constant HEVM_ADDRESS = address(bytes20(uint160(uint256(keccak256("hevm cheat code")))));
    Vm constant vm = Vm(HEVM_ADDRESS);

    // keccak256("getPriceUnsafe(bytes32,bytes32)");
    bytes4 constant getPrice = 0x96834ad3; //0x31d98b3f;

    struct Context {
        PythUpgradable pythUpgradeable;
    }

    /**
     * @dev Mocks oracle data for testing purposes. This function allows simulating oracle data
     * within a test environment, enabling the testing of contract interactions with oracles.
     * @param pid The price feed ID of the oracle data to mock.
     * @param price The price of the base token in terms of the quote token.
     */
    function mockOracleData(bytes32 pid, int64 price) internal {
        Context memory context = context();
        require(context.pythUpgradeable.priceFeedExists(pid), "PythOracle: Price feed not found");

        PythUpgradable.Price memory pythPrice = context.pythUpgradeable.getPriceUnsafe(pid);
        pythPrice.price = price;

        vm.mockCall(address(context.pythUpgradeable), abi.encodePacked(getPrice, pid), abi.encode(pythPrice));
    }

    /**
     * @dev Retrieves the context information relevant to the current blockchain environment.
     * This function checks the chain ID and returns the corresponding context information,
     * allowing the contract to adapt to different blockchain environments.
     * @return Context The context information for the current blockchain.
     */
    function context() public view returns (Context memory) {
        address pythUpgradeable;

        if (block.chainid == 1) {
            // Ethereum mainnet
            pythUpgradeable = 0x4305FB66699C3B2702D4d05CF36551390A4c69C6;
        } else {
            revert("PythOracle: Chain not supported");
        }

        return Context(PythUpgradable(pythUpgradeable));
    }
}

interface PythUpgradable {
    type GovernanceAction is uint8;
    type GovernanceModule is uint8;

    struct AuthorizeGovernanceDataSourceTransferPayload {
        bytes claimVaa;
    }

    struct DataSource {
        uint16 chainId;
        bytes32 emitterAddress;
    }

    struct GovernanceInstruction {
        GovernanceModule module;
        GovernanceAction action;
        uint16 targetChainId;
        bytes payload;
    }

    struct Price {
        int64 price;
        uint64 conf;
        int32 expo;
        uint256 publishTime;
    }

    struct PriceFeed {
        bytes32 id;
        Price price;
        Price emaPrice;
    }

    struct RequestGovernanceDataSourceTransferPayload {
        uint32 governanceDataSourceIndex;
    }

    struct SetDataSourcesPayload {
        DataSource[] dataSources;
    }

    struct SetFeePayload {
        uint256 newFee;
    }

    struct SetValidPeriodPayload {
        uint256 newValidPeriod;
    }

    struct SetWormholeAddressPayload {
        address newWormholeAddress;
    }

    struct UpgradeContractPayload {
        address newImplementation;
    }

    error InsufficientFee();
    error InvalidArgument();
    error InvalidGovernanceDataSource();
    error InvalidGovernanceMessage();
    error InvalidGovernanceTarget();
    error InvalidUpdateData();
    error InvalidUpdateDataSource();
    error InvalidWormholeAddressToSet();
    error InvalidWormholeVaa();
    error NoFreshUpdate();
    error OldGovernanceMessage();
    error PriceFeedNotFound();
    error PriceFeedNotFoundWithinRange();
    error StalePrice();

    event AdminChanged(address previousAdmin, address newAdmin);
    event BatchPriceFeedUpdate(uint16 chainId, uint64 sequenceNumber);
    event BeaconUpgraded(address indexed beacon);
    event ContractUpgraded(address oldImplementation, address newImplementation);
    event DataSourcesSet(DataSource[] oldDataSources, DataSource[] newDataSources);
    event FeeSet(uint256 oldFee, uint256 newFee);
    event GovernanceDataSourceSet(DataSource oldDataSource, DataSource newDataSource, uint64 initialSequence);
    event Initialized(uint8 version);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event PriceFeedUpdate(bytes32 indexed id, uint64 publishTime, int64 price, uint64 conf);
    event Upgraded(address indexed implementation);
    event ValidPeriodSet(uint256 oldValidPeriod, uint256 newValidPeriod);
    event WormholeAddressSet(address oldWormholeAddress, address newWormholeAddress);

    function chainId() external view returns (uint16);
    function executeGovernanceInstruction(bytes memory encodedVM) external;
    function getEmaPrice(bytes32 id) external view returns (Price memory price);
    function getEmaPriceNoOlderThan(bytes32 id, uint256 age) external view returns (Price memory price);
    function getEmaPriceUnsafe(bytes32 id) external view returns (Price memory price);
    function getPrice(bytes32 id) external view returns (Price memory price);
    function getPriceNoOlderThan(bytes32 id, uint256 age) external view returns (Price memory price);
    function getPriceUnsafe(bytes32 id) external view returns (Price memory price);
    function getUpdateFee(bytes[] memory updateData) external view returns (uint256 feeAmount);
    function getUpdateFee(uint256 updateDataSize) external view returns (uint256 feeAmount);
    function getValidTimePeriod() external view returns (uint256);
    function governanceDataSource() external view returns (DataSource memory);
    function governanceDataSourceIndex() external view returns (uint32);
    function hashDataSource(DataSource memory ds) external pure returns (bytes32);
    function initialize(
        address wormhole,
        uint16[] memory dataSourceEmitterChainIds,
        bytes32[] memory dataSourceEmitterAddresses,
        uint16 governanceEmitterChainId,
        bytes32 governanceEmitterAddress,
        uint64 governanceInitialSequence,
        uint256 validTimePeriodSeconds,
        uint256 singleUpdateFeeInWei
    ) external;
    function isValidDataSource(uint16 dataSourceChainId, bytes32 dataSourceEmitterAddress)
        external
        view
        returns (bool);
    function isValidGovernanceDataSource(uint16 governanceChainId, bytes32 governanceEmitterAddress)
        external
        view
        returns (bool);
    function lastExecutedGovernanceSequence() external view returns (uint64);
    function latestPriceInfoPublishTime(bytes32 priceId) external view returns (uint64);
    function owner() external view returns (address);
    function parseAuthorizeGovernanceDataSourceTransferPayload(bytes memory encodedPayload)
        external
        pure
        returns (AuthorizeGovernanceDataSourceTransferPayload memory sgds);
    function parseGovernanceInstruction(bytes memory encodedInstruction)
        external
        pure
        returns (GovernanceInstruction memory gi);
    function parsePriceFeedUpdates(
        bytes[] memory updateData,
        bytes32[] memory priceIds,
        uint64 minPublishTime,
        uint64 maxPublishTime
    ) external payable returns (PriceFeed[] memory priceFeeds);
    function parseRequestGovernanceDataSourceTransferPayload(bytes memory encodedPayload)
        external
        pure
        returns (RequestGovernanceDataSourceTransferPayload memory sgdsClaim);
    function parseSetDataSourcesPayload(bytes memory encodedPayload)
        external
        pure
        returns (SetDataSourcesPayload memory sds);
    function parseSetFeePayload(bytes memory encodedPayload) external pure returns (SetFeePayload memory sf);
    function parseSetValidPeriodPayload(bytes memory encodedPayload)
        external
        pure
        returns (SetValidPeriodPayload memory svp);
    function parseSetWormholeAddressPayload(bytes memory encodedPayload)
        external
        pure
        returns (SetWormholeAddressPayload memory sw);
    function parseUpgradeContractPayload(bytes memory encodedPayload)
        external
        pure
        returns (UpgradeContractPayload memory uc);
    function priceFeedExists(bytes32 id) external view returns (bool);
    function proxiableUUID() external view returns (bytes32);
    function pythUpgradableMagic() external pure returns (uint32);
    function queryPriceFeed(bytes32 id) external view returns (PriceFeed memory priceFeed);
    function renounceOwnership() external;
    function singleUpdateFeeInWei() external view returns (uint256);
    function transferOwnership(address newOwner) external;
    function updatePriceFeeds(bytes[] memory updateData) external payable;
    function updatePriceFeedsIfNecessary(
        bytes[] memory updateData,
        bytes32[] memory priceIds,
        uint64[] memory publishTimes
    ) external payable;
    function upgradeTo(address newImplementation) external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
    function validDataSources() external view returns (DataSource[] memory);
    function validTimePeriodSeconds() external view returns (uint256);
    function version() external pure returns (string memory);
    function wormhole() external view returns (address);
}