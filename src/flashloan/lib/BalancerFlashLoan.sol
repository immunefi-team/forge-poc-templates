pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";

library BalancerFlashLoan {
    struct Context {
        IBalancer balancerVault;
    }

    address constant BALANCER_VAULT_ADDR = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    bytes4 constant CALLBACK_SELECTOR = 0xf04f2707; // keccak256(receiveFlashLoan(address[], uint256[], uint256[], bytes))

    /**
     * @dev Takes a flash loan from the Balancer Vault.
     * @param tokens The addresses of the tokens to borrow.
     * @param amounts The amount of each token to borrow.
     */
    function takeFlashLoan(address[] memory tokens, uint256[] memory amounts) internal {
        Context memory context = context();
        context.balancerVault.flashLoan(address(this), tokens, amounts, "");
    }

    /**
     * @dev Takes a flash loan from the Balancer Vault.
     * @param token The address of the token to borrow.
     * @param amount The amount of the token to borrow.
     */
    function takeFlashLoan(address token, uint256 amount) internal {
        Context memory context = context();

        address[] memory tokens = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        tokens[0] = token;
        amounts[0] = amount;

        context.balancerVault.flashLoan(address(this), tokens, amounts, "");
    }

    /**
     * @dev Pays back a flash loan to the Balancer Vault.
     * @param data The calldata received from the callback function of the Balancer Vault.
     */
    function payFlashLoan(bytes calldata data) internal {
        (address[] memory tokens, uint256[] memory amounts, uint256[] memory feeAmounts) = unpackData(data);
        Context memory context = context();
        require(
            msg.sender == address(context.balancerVault), "BalancerFlashLoan: Callback msg.sender was not the Balancer"
        );
        for (uint256 i = 0; i < tokens.length; i++) {
            IERC20(tokens[i]).transfer(msg.sender, amounts[i] + feeAmounts[i]);
        }
    }

    /**
     * @dev Unpacks the data received from the Balancer Vault callback function.
     * @param data The calldata received from the callback function.
     * returns A tuple of the borrowed tokens, amounts, and fee amounts.
     * @return token The addresses of the borrowed tokens
     * @return amount The amounts of the borrowed tokens
     * @return feeAmount The fee amounts of the borrowed tokens
     */
    function unpackData(bytes calldata data)
        internal
        pure
        returns (address[] memory token, uint256[] memory amount, uint256[] memory feeAmount)
    {
        bytes memory params = data[4:]; // skipping the function selector
        (address[] memory tokens, uint256[] memory amounts, uint256[] memory feeAmounts, bytes memory userData) =
            abi.decode(params, (address[], uint256[], uint256[], bytes));

        return (tokens, amounts, feeAmounts);
    }

    /**
     * @dev Returns the context for the library, including the address of the Balancer Vault.
     * @return The context for the library.
     */
    function context() internal view returns (Context memory) {
        IBalancer balancerVault;

        if (block.chainid == 1) {
            // Ethereum mainnet
            balancerVault = IBalancer(BALANCER_VAULT_ADDR);
        } else {
            revert("BalancerFlashLoan: Chain not supported");
        }

        return Context(balancerVault);
    }
}

interface IBalancer {
    /**
     * @dev Takes a flash loan from the Balancer Vault.
     * @param recipient The address of the recipient of the flash loan.
     * @param tokens The addresses of the tokens to borrow.
     * @param amounts The amount of each token to borrow.
     * @param userData Additional data to pass to the Balancer Vault.
     */
    function flashLoan(address recipient, address[] memory tokens, uint256[] memory amounts, bytes memory userData)
        external;
}
