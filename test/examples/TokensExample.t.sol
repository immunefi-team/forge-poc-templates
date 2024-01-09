pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/tokens/examples/TokenExampleManipulation.sol";
import "../../src/tokens/Tokens.sol";

contract TokensExampleTest is Test {
    uint256 mainnetFork;

    TokenExampleManipulation public tokenExample;

    function setUp() public {
        mainnetFork = vm.createFork("eth");
        vm.selectFork(mainnetFork);

        tokenExample = new TokenExampleManipulation();
    }

    function testTokenManipulation() public {
        console.log("Balance before:", EthereumTokens.WETH.balanceOf(address(tokenExample)));
        tokenExample.manipulateTokenBalance();
        console.log("Balance after:", EthereumTokens.WETH.balanceOf(address(tokenExample)));
    }
}
