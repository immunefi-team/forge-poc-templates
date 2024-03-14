<a href="https://immunefi.com"><img src="https://github.com/immunefi-team/forge-poc-templates/blob/assets/imgs/Logo_white@3x.png"/></a>


[![GitHub issues](https://img.shields.io/github/issues/immunefi-team/forge-poc-templates.svg)](https://GitHub.com/immunefi-team/forge-poc-templates/issues/)
[![Foundry][foundry-badge]][foundry]
[![LGPLv3 license](https://img.shields.io/badge/License-LGPLv3-blue.svg)](./LICENSE)

[foundry]: https://getfoundry.sh/
[foundry-badge]: https://img.shields.io/badge/Built%20with-Foundry-FFDB1C.svg

[![Immunefi Discord](https://badgen.net/discord/online-members/immunefi)](https://discord.gg/immunefi)
[![Twitter](https://badgen.net/badge/icon/twitter?icon=twitter&label)](https://twitter.com/immunefi)
[![Medium](https://badgen.net/badge/icon/medium?icon=medium&label)](https://medium.com/immunefi)
[![YouTube](https://badgen.net/badge/icon/YouTube?icon=googleplay&label)](https://www.youtube.com/channel/UCmulw2BHpP6IiBM0Re0yP5Q)

## Overview

Welcome to the Immunefi PoC Templates repository! Here, you'll find reusable and easily modifiable Proof of Concept (PoC) examples for various Ethereum Virtual Machine (EVM) based vulnerabilities. Clone the branch corresponding to the chosen [attack template](#template-categories). The aim is to enhance bug reporting quality and provide whitehat hackers with efficient tools to create PoCs and validate their findings quickly. These templates are intended for testing proof of concepts in local forks for submission to bug bounty programs. Any other use is explicitly prohibited.

## Installation

To utilize this repository, you need to have Foundry installed. Check out the [installation guide](https://book.getfoundry.sh/getting-started/installation) for Foundry.

## Getting Started 📖

1. **Initialize Forge Repository**: Start by initializing a forge repository with the desired attack template. Use the command below, replacing `[template]` with the chosen template from the [Template Categories](#template-categories):
    ```
    forge init --template immunefi-team/forge-poc-templates --branch [template]
    ```

2. **Download Contract Interfaces**: Obtain contract interfaces either by creating your own or using Foundry's tools:
    - **Create Interface Automatically**: Use Foundry's `cast interface` commandline tool to automatically generate interfaces based on contract ABIs.

    ```
    cast interface [address] -o src/external/interfaces/IExample.sol -n IExample
    ```

    - **Download Entire Source Code**: Alternatively, download entire contract source codes using `cast etherscan-source` command line tool.

    ```
    cast etherscan-source [address] -d src/external
    ```

3. **Write the Test**: Import your attack contract into `PoCTest.sol` and modify the `setUp()` function to replicate necessary attack preconditions. Execute the attack in the `testAttack()` function.

    The test should extend the `PoC` contract, which introduces functionality to automatically snapshot and print account balances before and after a test.
    
    Use the modifier `snapshot(address account, IERC20[] tokens)` on the `test*` function to automatically print information such as pre-attack balances, post-attack balances, and profit. Passing a token with address(0x0) corresponds to the native token of the chain.

## Running a PoC 🚀

To run a test, execute the following command in the console:
```
forge test -vv --match-path test/[test_name]
```

## Template Categories 🪲

Explore various vulnerability categories along with their respective branches, source codes, and documentation in the table below:

| Categorization | Branch | Source | Documentation |
| -------------- | ------ | ------ | ------------- |
| Default | [default](https://github.com/immunefi-team/forge-poc-templates/tree/default) |  |  |
| Reentrancy | [reentrancy](https://github.com/immunefi-team/forge-poc-templates/tree/reentrancy) | [Source](./src/reentrancy/Reentrancy.sol) | [Readme](./src/reentrancy/README.md) |
| Flash Loan | [flash_loan](https://github.com/immunefi-team/forge-poc-templates/tree/flash_loan) | [Source](./src/flashloan/FlashLoan.sol) | [Readme](./src/flashloan/README.md) |
| Price Manipulation | [price_manipulation](https://github.com/immunefi-team/forge-poc-templates/tree/price_manipulation) | [Source](./src/pricemanipulation/PriceManipulation.sol) | [Readme](./src/pricemanipulation/README.md) |
| Boilerplate Mocks | [mocks](./src/mocks/) | [Source](./src/mocks/) | [Readme](./src/mocks/README.md) |
| Oracle Mocks | [oracles](./src/oracle/) | [Source](./src/oracle/) | [Readme](./src/oracle/README.md) |
| Sandwich Attacks | [sandwich](https://github.com/immunefi-team/forge-poc-templates/tree/sandwich) |  |  |

## Foundry Concepts

Refer to [Foundry](https://book.getfoundry.sh/) for comprehensive understanding.

## Community PoCs ✨

Explore PoCs contributed by our community members:

- [Hundred Finance Hack](https://medium.com/immunefi/a-poc-of-the-hundred-finance-heist-4121f23a098) by [@hephyrius](https://twitter.com/hephyrius)
- [Omni Protocol Hack](https://medium.com/immunefi/hack-analysis-omni-protocol-july-2022-2d35091a0109) by [@realgmhacker](https://twitter.com/realgmhacker)
- [Euler Exploit PoC](https://github.com/iphelix/euler-exploit-poc) by [@iphelix](https://twitter.com/_iphelix)
- [DFX Finance Bugfix Review](./pocs/DFXFinanceBugfixReview.sol) by [@unsafe_call](https://twitter.com/unsafe_call)

## Contribute

We sincerely appreciate contributions to Immunefi's templates. Please review the [contribution guidelines](.github/CONTRIBUTING.md) and [code of conduct](.github/CODE_OF_CONDUCT.md) to ensure your contributions are merged as soon as possible.

## Contributors

Showcasing the contributors behind this project:

- [@unsafe_call](https://twitter.com/unsafe_call)
- [@Omikomikomik](https://twitter.com/omikomikomik)
- [@ArbazKiraak](https://twitter.com/ArbazKiraak)
- [@AdrianHetman](https://twitter.com/adrianhetman)
- [@Pep1nn](https://twitter.com/Pep1nn)
- [@realgmhacker](https://twitter.com/realgmhacker)
- [@_iphelix](https://twitter.com/_iphelix)
- [0xlead](https://github.com/0xlead)
- [@infosec_us_team](https://twitter.com/infosec_us_team)

## Need Assistance?

For any queries or concerns, please don't hesitate to raise them at [our GitHub issues](https://github.com/immunefi-team/forge-poc-templates/issues).

Finally, if you're eager to collaborate and searching for beginner-friendly tasks, explore the issues labeled as ["Good first issue"](https://github.com/immunefi-team/forge-poc-templates/labels/good%20first%20issue).

Thank you for your time and contributions! 🙌