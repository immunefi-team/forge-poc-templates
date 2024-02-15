pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";

/**
 * @custom:deprecated
 * @dev Euler flash loans no longer work due to the $187M hack on March 13, 2023.
 * Flash loans only work from block 16818068 or earlier.
 * https://github.com/iphelix/euler-exploit-poc
 */
library EulerFlashLoan {
    /**
     * @dev struct that hold the reference of Euler and the dToken
     */
    struct Context {
        address euler;
        IEulerDToken dToken;
    }

    bytes4 constant CALLBACK_SELECTOR = 0xc4850ea8; // keccak256(onFlashLoan(bytes memory data))

    /**
     * @dev Allows a user to take a flash loan from Euler for a given token and amount
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(address token, uint256 amount) internal {
        Context memory context = context(token);
        context.dToken.flashLoan(amount, abi.encode(token, amount));
    }

    /**
     * @dev Pay back the flash loan to Euler
     * @param data The data of the flash loan
     */
    function payFlashLoan(bytes calldata data) internal {
        (address token, uint256 amount) = unpackData(data);
        Context memory context = context(token);

        require(msg.sender == context.euler, "EulerFlashLoan: Callback msg.sender was not Euler");

        IERC20(token).transfer(msg.sender, amount);
    }

    /**
     * @dev Helper function that returns the context of the flash loan for a given token
     * @param token The address of the token of the flash loan
     * @return A struct containing the address of Euler and the dToken
     */
    function context(address token) internal view returns (Context memory) {
        IEulerMarkets markets;
        address euler;
        IEulerDToken dToken;

        if (block.chainid == 1) {
            // Ethereum mainnet
            markets = IEulerMarkets(0x3520d5a913427E6F0D6A83E07ccD4A4da316e4d3);
            euler = 0x27182842E098f60e3D576794A5bFFb0777E025d3;
        } else {
            revert("EulerFlashLoan: Chain not supported");
        }

        dToken = IEulerDToken(markets.underlyingToDToken(token));

        return Context(euler, dToken);
    }

    /**
     * @dev Helper function that decodes the flash loan data
     * @param data The data of the flash loan
     * @return token The address of the token of the flash loan
     * @return amount The amount of the token borrowed
     */
    function unpackData(bytes calldata data) internal pure returns (address token, uint256 amount) {
        (bytes memory params) = abi.decode(data[4:], (bytes));
        (token, amount) = abi.decode(params, (address, uint256));
        return (token, amount);
    }
}

interface IEulerDToken {
    function flashLoan(uint256 amount, bytes calldata data) external;
}

interface IEulerMarkets {
    function underlyingToDToken(address token) external view returns (address);
}
