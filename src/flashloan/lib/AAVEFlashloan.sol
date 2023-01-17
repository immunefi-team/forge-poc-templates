pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library AAVEFlashLoan {
    /**
     * @dev struct that hold the reference of IAAVELendingPool and address core
     */
    struct Context {
        IAAVELendingPool AAVElendingPool;
        address core;
    }

    /**
     * @dev Allows a user to take a flash loan from AAVE Lending Pool for a given token and amount
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(address token, uint256 amount) internal {
        Context memory context = context();
        require(address(context.AAVElendingPool) != address(0), "AAVEFlashloan: Query to AAVElendingPool failed.");

        context.AAVElendingPool.flashLoan(address(this), token, amount, "");
    }

    /**
     * @dev Pay back the flash loan to AAVE Lending Pool
     * @param data The data of the flash loan
     */
    function payFlashLoan(bytes calldata data) internal {
        Context memory context = context();
        (address asset, uint256 amount, uint256 fee, bytes memory params) = unpackData(data);

        require(msg.sender == address(context.AAVElendingPool), "AAVEFlashloan: Callback msg.sender was not the lending pool");

        IERC20(asset).approve(address(context.core), amount + fee);
        IERC20(asset).transfer(context.core, amount + fee);
    }

    /**
     * @dev Helper function which returns the on chain context needed to execute a flashloan
     * @return The context of the flashloan
     */
    function context() internal returns (Context memory) {
        ILendingPoolAddressesProvider AAVELendingPoolProvider;

        if (block.chainid == 1) {
            // Ethereum mainnet
            AAVELendingPoolProvider = ILendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);
        } else if (block.chainid == 56) {
            // Binance Smart Chain mainnet
        } else if (block.chainid == 137) {
            // Polygon mainnet
        } else if (block.chainid == 43114) {
            // Avalanche C-Chain
        } else if (block.chainid == 10) {
            // Optimism
        } else {
            revert("AAVEFlashloan: Chain not supported");
        }

        IAAVELendingPool AAVElendingPool = IAAVELendingPool(AAVELendingPoolProvider.getLendingPool());
        address core = AAVElendingPool.core();
        return Context(AAVElendingPool, core);
    }

    /**
     * @dev Helper function which decodes the flash loan callback data
     * @param data The data of the flash loan
     * @return asset The address of the asset borrowed 
     * @return amount The amount of the asset borrowed
     * @return fee The fee associated with the flash loan
     * @return params Additional params associated with the flash loan
     */
    function unpackData(bytes calldata data)
        internal
        returns (address asset, uint256 amount, uint256 fee, bytes memory params)
    {
        (asset, amount, fee, params) = abi.decode(data[4:], (address, uint256, uint256, bytes));
        return (asset, amount, fee, params);
    }
}

interface IAAVELendingPool {
    function flashLoan(address _receiver, address _reserve, uint256 _amount, bytes memory _params) external;
    function flashLoan(
        address receiver,
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata modes,
        address onBehalfOf,
        bytes calldata params,
        uint16 referralCode
    ) external;
    function core() external view returns (address);
}

interface ILendingPoolAddressesProvider {
    function getLendingPool() external view returns (address);
    function setLendingPoolImpl(address _pool) external;
    function getLendingPoolCore() external view returns (address payable);
    function setLendingPoolCoreImpl(address _lendingPoolCore) external;
    function getLendingPoolConfigurator() external view returns (address);
    function setLendingPoolConfiguratorImpl(address _configurator) external;
    function getLendingPoolDataProvider() external view returns (address);
    function setLendingPoolDataProviderImpl(address _provider) external;
    function getLendingPoolParametersProvider() external view returns (address);
    function setLendingPoolParametersProviderImpl(address _parametersProvider) external;
    function getTokenDistributor() external view returns (address);
    function setTokenDistributor(address _tokenDistributor) external;
    function getFeeProvider() external view returns (address);
    function setFeeProviderImpl(address _feeProvider) external;
    function getLendingPoolLiquidationManager() external view returns (address);
    function setLendingPoolLiquidationManager(address _manager) external;
    function getLendingPoolManager() external view returns (address);
    function setLendingPoolManager(address _lendingPoolManager) external;
    function getPriceOracle() external view returns (address);
    function setPriceOracle(address _priceOracle) external;
    function getLendingRateOracle() external view returns (address);
    function setLendingRateOracle(address _lendingRateOracle) external;
}
