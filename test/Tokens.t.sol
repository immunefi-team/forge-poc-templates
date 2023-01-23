// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenTemplate.sol";

contract TokensTemplateTest is Test {
    uint256 mainnetFork;
    string RPC_URL = vm.envString("RPC_URL");

    TokenTemplate public tokenTemplate;

    function setUp() public {
        mainnetFork = vm.createFork(RPC_URL);
        vm.selectFork(mainnetFork);

        tokenTemplate = new TokenTemplate();
    }

    function testAttack() public {
        tokenTemplate.initiateAttack();
    }
}
