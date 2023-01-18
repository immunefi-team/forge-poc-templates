pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library AAVEV1FlashLoan {
    /**
     * @dev struct that hold the reference of IAAVEV1LendingPool and address core
     */
    struct Context {
        IAAVEV1LendingPool AAVElendingPool;
        address core;
    }

    bytes4 constant CALLBACK_SELECTOR = 0xee872558;

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

        require(
            msg.sender == address(context.AAVElendingPool),
            "AAVEV1FlashLoan: Callback msg.sender was not the lending pool"
        );

        IERC20(asset).transfer(context.core, amount + fee);
    }

    /**
     * @dev Helper function which returns the on chain context needed to execute a flashloan
     * @return The context of the flashloan
     */
    function context() internal returns (Context memory) {
        IAAVEV1LendingPoolAddressesProvider lendingPoolProvider;

        if (block.chainid == 1) {
            // Ethereum mainnet
            lendingPoolProvider = IAAVEV1LendingPoolAddressesProvider(0x24a42fD28C976A61Df5D00D0599C34c4f90748c8);
        } else {
            revert("AAVEV1FlashLoan: Chain not supported");
        }

        IAAVEV1LendingPool lendingPool = IAAVEV1LendingPool(lendingPoolProvider.getLendingPool());
        address core = lendingPool.core();
        return Context(lendingPool, core);
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

interface IAAVEV1LendingPool {
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

interface IAAVEV1LendingPoolAddressesProvider {
    function getLendingPool() external view returns (address);
}
