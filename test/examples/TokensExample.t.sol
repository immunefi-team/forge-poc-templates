// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/tokens/examples/TokenExampleManipulation.sol";
import "../src/tokens/Tokens.sol";

contract TokensExampleTest is Test {
    uint256 mainnetFork;
    string RPC_URL = vm.envString("RPC_URL");

    TokenExampleManipulation public tokenExample;

    function setUp() public {
        mainnetFork = vm.createFork(RPC_URL);
        vm.selectFork(mainnetFork);

        tokenExample = new TokenExampleManipulation();
    }

    function testTokenManipulation() public {
        console.log("Balance before:", EthereumTokens.USDC.balanceOf(address(tokenExample)));
        tokenExample.manipulateTokenBalance();
        console.log("Balance after:", EthereumTokens.USDC.balanceOf(address(tokenExample)));
    }
}
