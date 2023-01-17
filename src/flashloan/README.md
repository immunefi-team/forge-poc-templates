## Vulnerability Type
This template is for getting started with attack PoCs which use flash loans. The flash loan template supports flash loans from the following protocols/chains:

<details>
  <summary>

### Ethereum
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Ethereum | AAVE     | [AAVEFlashLoan](./lib/AAVEFlashLoan.sol) |
| Ethereum | Euler      | [EulerFlashLoan](./lib/EulerFlashLoan.sol) |

</details>
<details>
  <summary>

### Binance
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Ethereum | AAVE     | [AAVEFlashLoan](./lib/AAVEFlashLoan.sol) |

</details>

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