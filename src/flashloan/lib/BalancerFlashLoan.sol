pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library BalancerFlashLoan {
    struct Context {
        IBalancer balancerVault;
    }

    address constant BALANCER_VAULT_ADDR = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    bytes4 constant CALLBACK_SELECTOR = 0xf04f2707; // keccak256(receiveFlashLoan(address[], uint256[], uint256[], bytes))

    function takeFlashLoan(address[] memory tokens, uint256[] memory amounts) internal {
        Context memory context = context();
        context.balancerVault.flashLoan(address(this), tokens, amounts, "");
    }

    function takeFlashLoan(address token, uint256 amount) internal {
        Context memory context = context();

        address[] memory tokens = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        tokens[0] = token;
        amounts[0] = amount;

        context.balancerVault.flashLoan(address(this), tokens, amounts, "");
    }

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

    function unpackData(bytes calldata data)
        internal
        returns (address[] memory token, uint256[] memory amount, uint256[] memory feeAmount)
    {
        bytes memory params = data[4:]; // skipping the function selector
        (address[] memory tokens, uint256[] memory amounts, uint256[] memory feeAmounts, bytes memory userData) =
            abi.decode(params, (address[], uint256[], uint256[], bytes));

        return (tokens, amounts, feeAmounts);
    }

    function context() internal returns (Context memory) {
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
    function flashLoan(address recipient, address[] memory tokens, uint256[] memory amounts, bytes memory userData)
        external;
}
