pragma solidity ^0.8.0;

import "forge-std-1.9.4/src/interfaces/IERC20.sol";

library AAVEV2FlashLoan {
    /**
     * @dev struct that hold the reference of IAAVEV3LendingPool
     */
    struct Context {
        IAAVEV2Pool AAVEPool;
    }

    bytes4 constant CALLBACK_SELECTOR = 0x920f5c84; // keccak256(executeOperation(address[] assets, uint256[] amounts, uint256[] premiums, address initator, bytes calldata params))
    bytes constant RETURN_DATA = abi.encode(uint256(0x1)); // bool (true)

    /**
     * @dev Allows a user to take a flash loan from AAVE Lending Pool for a given token and amount
     * @param tokens The addresses of the tokens to borrow
     * @param amounts The amounts of the tokens to borrow
     */
    function takeFlashLoan(address[] memory tokens, uint256[] memory amounts) internal {
        Context memory context = context();
        require(address(context.AAVEPool) != address(0), "AAVEV2Flashloan: Query to AAVElendingPool failed.");
        uint256[] memory modes = new uint256[](tokens.length);

        context.AAVEPool.flashLoan(address(this), tokens, amounts, modes, address(this), "", 0);
    }

    /**
     * @dev Allows a user to take a flash loan from AAVE Lending Pool for a given token and amount
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(address token, uint256 amount) internal {
        Context memory context = context();
        require(address(context.AAVEPool) != address(0), "AAVEV2Flashloan: Query to AAVElendingPool failed.");

        address[] memory tokens = new address[](1);
        uint256[] memory amounts = new uint256[](1);
        uint256[] memory modes = new uint256[](1);

        tokens[0] = token;
        amounts[0] = amount;

        context.AAVEPool.flashLoan(address(this), tokens, amounts, modes, address(this), "", 0);
    }

    /**
     * @dev Pay back the flash loan to AAVE Lending Pool
     * @param data The data of the flash loan
     */
    function payFlashLoan(bytes calldata data) internal {
        Context memory context = context();
        (
            address[] memory assets,
            uint256[] memory amounts,
            uint256[] memory premiums,
            address initiator,
            bytes memory params
        ) = unpackData(data);

        require(msg.sender == address(context.AAVEPool), "AAVEV2FlashLoan: Callback msg.sender was not the pool");

        for (uint256 i = 0; i < assets.length; i++) {
            IERC20(assets[i]).approve(address(context.AAVEPool), amounts[i] + premiums[i]);
        }
    }

    /**
     * @dev Helper function which returns the on chain context needed to execute a flashloan
     * @return The context of the flashloan
     */
    function context() internal view returns (Context memory) {
        IAAVEV2PoolAddressesProvider poolAddressesProvider;

        if (block.chainid == 1) {
            // Ethereum mainnet
            poolAddressesProvider = IAAVEV2PoolAddressesProvider(0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5);
        } else if (block.chainid == 137) {
            // Polygon
            poolAddressesProvider = IAAVEV2PoolAddressesProvider(0xd05e3E715d945B59290df0ae8eF85c1BdB684744);
        } else if (block.chainid == 43114) {
            // Avalanche
            poolAddressesProvider = IAAVEV2PoolAddressesProvider(0xb6A86025F0FE1862B372cb0ca18CE3EDe02A318f);
        } else {
            revert("AAVEV2FlashLoan: Chain not supported");
        }

        IAAVEV2Pool lendingPool = IAAVEV2Pool(poolAddressesProvider.getLendingPool());
        return Context(lendingPool);
    }

    /**
     * @dev Helper function which decodes the flash loan callback data
     * @param data The data of the flash loan
     * @return assets The address of the asset borrowed
     * @return amounts The amount of the asset borrowed
     * @return premiums The fee associated with the flash loan
     * @return initiator The account which initiated the flash loan
     * @return params Additional params associated with the flash loan
     */
    function unpackData(bytes calldata data)
        internal
        pure
        returns (
            address[] memory assets,
            uint256[] memory amounts,
            uint256[] memory premiums,
            address initiator,
            bytes memory params
        )
    {
        (assets, amounts, premiums, initiator, params) =
            abi.decode(data[4:], (address[], uint256[], uint256[], address, bytes));
        return (assets, amounts, premiums, initiator, params);
    }
}

interface IAAVEV2Pool {
    function flashLoan(
        address receiverAddress,
        address[] calldata assets,
        uint256[] calldata amounts,
        uint256[] calldata interestRateModes,
        address behalfOf,
        bytes calldata params,
        uint16 referralCode
    ) external;
}

interface IAAVEV2PoolAddressesProvider {
    function getLendingPool() external view returns (address);
}
