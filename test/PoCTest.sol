// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@immunefi/src/PoC.sol";
import "../src/AttackContract.sol";

contract PoCTest is PoC {
    AttackContract public attackContract;
    IERC20[] tokens;

    function setUp() public {
        // Fork from specified block chain at block
        vm.createSelectFork("https://rpc.ankr.com/eth"); // , block_number);

        // Deploy attack contract
        attackContract = new AttackContract();

        // Fund attacker contract
        deal(EthereumTokens.USDC, address(attackContract), 1 * 10 ** 10);

        // Tokens to track during snapshotting
        tokens.push(EthereumTokens.USDC);
        tokens.push(EthereumTokens.cDAI);

        setAlias(address(attackContract), "Attacker");

        console.log("\n>>> Initial conditions");
    }

    function testAttack() public snapshot(address(attackContract), tokens) {
        attackContract.initializeAttack();
        deal(EthereumTokens.USDC, address(attackContract), 0);
    }
}
