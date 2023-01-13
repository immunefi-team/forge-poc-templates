pragma solidity ^0.8.0;

import "../Tokens.sol";

contract TokenExampleManipulation is Tokens {
    function manipulateTokenBalance() external {
        deal(EthereumTokens.USDC, address(this), 1 ether);
    }
}