## Vulnerability Type
This template is for getting started with attack PoCs which use flash loans. The flash loan template supports flash loans from the following protocols/chains:

<details>
  <summary>

### Ethereum
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Ethereum | AAVEV1     | [AAVEV1FlashLoan](./lib/AAVEV1FlashLoan.sol) |
| Ethereum | Euler      | [EulerFlashLoan](./lib/EulerFlashLoan.sol) |
| Ethereum | Balancer   | [BalancerFlashLoan](./lib/BalancerFlashLoan.sol) |
| Ethereum | MakerDAO   | [MakerDAOFlashLoan](./lib/MakerDAOFlashLoan.sol) |
| Ethereum | UniswapV2  | [UniswapV2FlashLoan](./lib/UniswapV2FlashLoan.sol) |

</details>
<!---
<details>
  <summary>

### Binance
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Ethereum | AAVE     | [AAVEFlashLoan](./lib/AAVEFlashLoan.sol) |

</details>
--->

## Usage
The following attack contract demonstrate simple flash loan usage.
* [FlashLoanExample](./examples/FlashLoanExample.sol)


Extend the FlashLoan contract and implement the following functions:
```Solidity
contract Attack is FlashLoan {
    function initiateAttack() external override { }
    function _executeAttack() internal override { }
    function _completeAttack() internal override { }
}
```
Call `takeFlashLoan(FlashLoanProviders flp, address token, uint256 amount)` in `initiateAttack()` to trigger your attack.

The following attack contract demonstrate multi provider flash loan usage.
* [MultiProviderFlashLoanExample](./examples/MultiProviderFlashLoanExample.sol)

Each time a flash loan is taken, the `_executeAttack()` function is called when the provider calls the flash loan callback. The context of the current execution call can be determined by calling `currentProvider()`, which returns the Flash Loan Provider which initiated the callback. This can be used as a state machine to execute stages of an attack. See the example for more.


> 🚨 Multiple flash loans cannot be taken from the same provider due to reentrancy protections. If you need to flash loan multiple tokens, you will have to use multiple providers unless the provider specifically supports multi-token flash loans.
