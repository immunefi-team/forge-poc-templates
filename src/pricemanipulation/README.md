## Vulnerability Type
This template is for getting started with attack PoCs which use price manipulation on weak or potentially unsafely integrated oracles. The price manipulation template support manipulation of the following price oracles.

<details>
  <summary>

### Ethereum
  </summary>

| Network | Protocol | Library |
| ---------- | -------- | ------------------------------------------------------- |
| Ethereum | Curve     | [Curve](./lib/CurvePriceManipulation.sol) |

</details>

## Usage
The following attack contract demonstrate simple flash loan usage.
* [PriceManipulationExample](./examples/PriceManipulationExample.sol)


Extend the PriceManipulation contract and implement the following functions:
```Solidity
contract Attack is PriceManipulation {
    function initiateAttack() external { }
    function _executeAttack() internal override { }
    function _completeAttack() internal override { }
}
```
Call `manipulatePrice(PriceManipulationProviders pmp, IERC20 token0, IERC20 token1, uint256 amount0, uint256 amount1)` in `initiateAttack()` to trigger your attack. The underlying function will call `_executeAttack()` during the manipulated price.