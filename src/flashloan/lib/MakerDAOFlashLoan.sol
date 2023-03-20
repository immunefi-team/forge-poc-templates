pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";

library MakerDAOFlashLoan {
    /**
     * @dev struct that hold the reference of dssFlash contract
     */
    struct Context {
        IDssFlash dssFlash;
    }

    bytes4 constant CALLBACK_SELECTOR = 0x23e30c8b; // keccak256(flashLoan(address initiator, address token, uint256 amount, uint256 fee, bytes memory data))
    bytes constant RETURN_DATA = abi.encode(bytes32(0x439148f0bbc682ca079e46d6e2c2f0c1e3b820f1a291b069d8882abf8cf18dd9)); // keccak256(ERC3156FlashBorrower.onFlashLoan)

    /**
     * @dev Allows a user to take a flash loan from MakerDAO for a given token and amount
     * @dev Only DAI is supported for MakerDAO's flash mint
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(address token, uint256 amount) internal {
        Context memory context = context();

        context.dssFlash.flashLoan(address(this), token, amount, "");
    }

    /**
     * @dev Pay back the flash loan to MakerDAO by making an approval
     * @param data The data of the flash loan
     */
    function payFlashLoan(bytes calldata data) internal {
        (address initiator, address token, uint256 amount, uint256 fee, bytes memory data) = unpackData(data);
        Context memory context = context();

        require(msg.sender == address(context.dssFlash), "MakerDAOFlashLoan: Callback msg.sender was not Maker DAO");

        IERC20(token).approve(msg.sender, amount + fee);
    }

    /**
     * @dev Helper function that returns the context of the flash loan for a given token
     * @return A struct containing the address of the dssFlash contract
     */
    function context() internal view returns (Context memory) {
        IDssFlash dssFlash;

        if (block.chainid == 1) {
            // Ethereum mainnet
            dssFlash = IDssFlash(0x60744434d6339a6B27d73d9Eda62b6F66a0a04FA);
        } else {
            revert("MakerDAOFlashLoan: Chain not supported");
        }

        return Context(dssFlash);
    }

    /**
     * @dev Helper function that decodes the flash loan data
     * @param data The data of the flash loan
     * @return initiator The address of the account which initiated the flash loan call
     * @return token The address of the token of the flash loan
     * @return amount The amount of the token borrowed
     * @return fee The amount of the token to be paid as a fee
     * @return data Encoded action from MakerDAO
     */
    function unpackData(bytes calldata _data)
        internal
        pure
        returns (address initiator, address token, uint256 amount, uint256 fee, bytes memory data)
    {
        (initiator, token, amount, fee, data) = abi.decode(_data[4:], (address, address, uint256, uint256, bytes));
        return (initiator, token, amount, fee, data);
    }
}

interface IDssFlash {
    function flashLoan(address receiver, address token, uint256 amount, bytes memory data) external;
    function dai() external view returns (address);
}
