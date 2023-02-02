## Vulnerability Type
This template is for getting started with reentrancy attack PoCs. The reentrancy template implements the callbacks for the following tokens to support reentrancy attacks:
* `onTokenTransfer(address, uint256, bytes)`
* `onTransferReceived(address, address, uint256, bytes)`
* `tokensReceived(address, address, address, bytes, bytes)`
* `onERC1155Received(address, address, uint256, uint256, bytes)`
* `onERC1155BatchReceived(address, address, uint256[], uint256[], bytes)`
* `onERC721Received(address, address, uint256, bytes)`
* `fallback()`
* `receive()`

## Usage
The following attack contract demonstrate a simple reentrancy attack on a improper implementation of a deposit and withdraw contract.
* [ReentrancyExampleAttack](./examples/ReentrancyExampleAttack.sol)


Extend the Reentrancy contract and implement the following functions:
```Solidity
contract Attack is Reentrancy {
    function initiateAttack() external { }
    function _executeAttack() internal override { }
    function _completeAttack() internal override { }
}
```

The `_reentrancyCallback` function in the Reentrancy template handles the callback from the vulnerable contract. Override this function to change the behavior of reentering multiple times.
```Solidity
/**
 * @dev Function run when target contract makes external call back to attack contract
 */
function _reentrancyCallback() incrementState internal virtual {
    console.log("Begin reentrancy stage %s", uint(reentrancyStage));
    if(reentrancyStage == State.ATTACK) {
        // Execute attack
        console.log("Execute attack");
        _executeAttack();
    } else if(reentrancyStage == State.POST_ATTACK) {
        // Already ran the attack once
        console.log("Attack completed successfully");
        _completeAttack();
    } else {
        // No state defined
    }
}
```
