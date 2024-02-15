## Vulnerability Type
This template is for getting started with attack PoCs which use flash loans. The flash loan template supports flash loans from the following protocols/chains:

<details>
  <summary>

### Ethereum
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Ethereum | AAVEV1 ⚠️     | [AAVEV1FlashLoan](./lib/AAVEV1FlashLoan.sol) |
| Ethereum | AAVEV2     | [AAVEV2FlashLoan](./lib/AAVEV2FlashLoan.sol) |
| Ethereum | AAVEV3     | [AAVEV3FlashLoan](./lib/AAVEV3FlashLoan.sol) |
| Ethereum | Euler ⚠️     | [EulerFlashLoan](./lib/EulerFlashLoan.sol) |
| Ethereum | Balancer   | [BalancerFlashLoan](./lib/BalancerFlashLoan.sol) |
| Ethereum | MakerDAO   | [MakerDAOFlashLoan](./lib/MakerDAOFlashLoan.sol) |
| Ethereum | UniswapV2  | [UniswapV2FlashLoan](./lib/UniswapV2FlashLoan.sol) |
| Ethereum | UniswapV3  | [UniswapV3FlashLoan](./lib/UniswapV3FlashLoan.sol) |

</details>
<details>
  <summary>

### Gnosis
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Gnosis  | UNISWAPV2   | [UniswapV2FlashLoan](./lib/UniswapV2FlashLoan.sol) |

</details>
<details>
  <summary>

### Optimism
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Optimism | AAVEV3     | [AAVEV3FlashLoan](./lib/AAVEV3FlashLoan.sol) |

</details>
<details>
  <summary>

### Arbitrum
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Arbitrum | AAVEV3     | [AAVEV3FlashLoan](./lib/AAVEV3FlashLoan.sol) |

</details>
<details>
  <summary>

### Polygon
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Polygon | AAVEV2     | [AAVEV2FlashLoan](./lib/AAVEV2FlashLoan.sol) |
| Polygon | AAVEV3     | [AAVEV3FlashLoan](./lib/AAVEV3FlashLoan.sol) |

</details>
<details>
  <summary>

### Fantom
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Fantom | AAVEV3     | [AAVEV3FlashLoan](./lib/AAVEV3FlashLoan.sol) |

</details>
<details>
  <summary>

### Avalanche
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Avalanche | AAVEV2     | [AAVEV2FlashLoan](./lib/AAVEV2FlashLoan.sol) |
| Avalanche | AAVEV3     | [AAVEV3FlashLoan](./lib/AAVEV3FlashLoan.sol) |

</details>

## Usage
The following attack contract demonstrate simple flash loan usage.
* [FlashLoanExample](./examples/FlashLoanExample.sol)


Extend the FlashLoan contract and implement the following functions:
```Solidity
contract Attack is FlashLoan {
    function initiateAttack() external { }
    function _executeAttack() internal override { }
    function _completeAttack() internal override { }
}
```
Call `takeFlashLoan(FlashLoanProviders flp, address token, uint256 amount)` in `initiateAttack()` to trigger your attack.

The following attack contract demonstrate multi provider flash loan usage.
* [MultiProviderFlashLoanExample](./examples/MultiProviderFlashLoanExample.sol)

Each time a flash loan is taken, the `_executeAttack()` function is called when the provider calls the flash loan callback. The context of the current execution call can be determined by calling `currentProvider()`, which returns the Flash Loan Provider which initiated the callback. This can be used as a state machine to execute stages of an attack. See the example for more. Flash loan repayment is handled automatically by the flash loan `_fallback()` handler.


> 🚨 Multiple flash loans cannot be taken from the same provider due to reentrancy protections. If you need to flash loan multiple tokens, you will have to use multiple providers unless the provider specifically supports multi-token flash loans.
