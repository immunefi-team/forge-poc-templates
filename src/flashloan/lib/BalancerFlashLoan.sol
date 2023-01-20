pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

library BalancerFlashLoan {
    struct Context {
        IBalancer balancerVault;
        address[] tokens;
        uint256[] amounts;
    }

    address constant BALANCER_VAULT_ADDR = 0xBA12222222228d8Ba445958a75a0704d566BF2C8;
    bytes4 constant CALLBACK_SELECTOR = 0xf04f2707; // keccak256(receiveFlashLoan(address[], uint256[], uint256[], bytes))

    function takeFlashLoan(address token, uint256 amount) internal {
        Context memory context = context(token,amount);
        context.balancerVault.flashLoan(address(this),context.tokens,context.amounts,"");
    }

    function payFlashLoan(bytes calldata data) internal {
        (address token, uint256 amount, uint256 feeAmount) = unpackData(data);
        require(msg.sender == BALANCER_VAULT_ADDR, "BalancerFlashLoan: Callback msg.sender was not the Balancer");
        IERC20(token).transfer(msg.sender, amount + feeAmount);
    }

    function unpackData(bytes calldata data) internal returns (address token, uint256 amount,uint256 feeAmount) {
        bytes memory params = data[4:]; // skipping the function selector
        (address[] memory tokens, uint256[] memory amounts, uint256[] memory feeAmounts,bytes memory userData) = abi.decode(params, (address[], uint256[],uint256[],bytes));
        
        address token = tokens[0];
        uint256 amount = amounts[0];
        uint256 feeAmount = feeAmounts[0];
        
        return (token, amount, feeAmount);
    }

    function context(address token,uint256 amount) internal returns (Context memory) {
        IBalancer balancerVault;

        address[] memory tokens = new address[](1);
        uint256[] memory amounts = new uint256[](1);

        tokens[0] = token;
        amounts[0] = amount;

        if (block.chainid == 1) {
            // Ethereum mainnet
            balancerVault = IBalancer(BALANCER_VAULT_ADDR);
        } else {
            revert("BalancerFlash: Chain not supported");
        }

        return Context(balancerVault, tokens, amounts);
    }
}


interface IBalancer {
    function flashLoan(
        address recipient,
        address[] memory tokens,
        uint256[] memory amounts,
        bytes memory userData
    ) external;
}