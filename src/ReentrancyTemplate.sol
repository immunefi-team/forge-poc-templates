pragma solidity ^0.8.13;

import "./reentrancy/Reentrancy.sol";

import "forge-std/console.sol";

contract ReentrancyTemplate is Reentrancy {
    // The victim to perform reentrancy attack on
    address target;

    constructor(address victim) {
        target = victim;
    }
    /**
     * @dev Initiates the reentrancy attack. Make any calls to the target contract, and continue reentrancy attack in the below callback function
     */
    function initiateAttack() external {
        // Initiate call to the target contract
        console.log("Initiating attack on %s", target);

        // TODO: Modify the attack here to initiate reentrancy in your victim
        // Interface(target).someFunction();
    }

    function _executeAttack() internal override {
        // TODO: Modify the attack here
    }

    function _completeAttack() internal override {
        console.log("Attacker balance after %s", address(this).balance);

        // TODO: Modify the attack cleanup here
    }
}
