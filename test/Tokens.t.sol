// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/tokens/examples/TokenExampleManipulation.sol";
import "../src/tokens/Tokens.sol";

contract TokensTest is Test {
    uint256 mainnetFork;
    string MAINNET_RPC_URL = vm.envString("ALCHEMY_API");

    TokenExampleManipulation public tokenExample;

    function setUp() public {
        mainnetFork = vm.createFork(MAINNET_RPC_URL);
        vm.selectFork(mainnetFork);

        tokenExample = new TokenExampleManipulation();
    }

    function testTokenManipulation() public {
        console.log("Balance before:", EthereumTokens.USDC.balanceOf(address(tokenExample)));
        tokenExample.manipulateTokenBalance();
        console.log("Balance after:", EthereumTokens.USDC.balanceOf(address(tokenExample)));
    }
}
