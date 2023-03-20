pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenTemplate.sol";

contract TokensTemplateTest is Test {
    uint256 mainnetFork;

    TokenTemplate public tokenTemplate;

    function setUp() public {
        mainnetFork = vm.createFork("eth");
        vm.selectFork(mainnetFork);

        tokenTemplate = new TokenTemplate();
    }

    function testAttack() public {
        tokenTemplate.initiateAttack();
    }
}
