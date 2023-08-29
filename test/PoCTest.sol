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
        deal(address(attackContract), 40000 ether);
        deal(EthereumTokens.wstETH, address(attackContract), 40000 ether);
        vm.prank(address(attackContract));
        address(EthereumTokens.wstETH).call(abi.encodeWithSignature("unwrap(uint256)", 40000 ether));

        // Tokens to track during snapshotting
        tokens.push(EthereumTokens.NATIVE_ASSET);
        tokens.push(EthereumTokens.stETH);

        setAlias(address(attackContract), "Attacker");

        console.log("\n>>> Initial conditions");
    }

    function testAttack() public snapshot(address(attackContract), tokens) {
        attackContract.initializeAttack();
    }
}
