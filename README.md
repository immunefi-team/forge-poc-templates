<a href="https://immunefi.com"><img src="https://github.com/immunefi-team/forge-poc-templates/blob/assets/imgs/Logo_white@3x.png"/></a>

[![GitHub issues](https://img.shields.io/github/issues/immunefi-team/forge-poc-templates.svg)](https://GitHub.com/immunefi-team/forge-poc-templates/issues/)
[![LGPLv3 license](https://img.shields.io/badge/License-LGPLv3-blue.svg)](./LICENSE)

[![Immunefi Discord](https://badgen.net/discord/online-members/immunefi)](https://discord.gg/immunefi)
[![Twitter](https://badgen.net/badge/icon/twitter?icon=twitter&label)](https://twitter.com/immunefi)
[![Medium](https://badgen.net/badge/icon/medium?icon=medium&label)](https://medium.com/immunefi)
[![YouTube](https://badgen.net/badge/icon/YouTube?icon=googleplay&label)](https://www.youtube.com/channel/UCmulw2BHpP6IiBM0Re0yP5Q)

This is a collaborative repository that aims to provide reusable and easily modifiable PoC examples for a variety of EVM based vulnerabilities. This will increase the quality of bug reports and allow whitehats an easier, faster way to create PoCs and verify their claims. These templates are intended for testing proof of concepts in local forks for submission to bug bounty programs. Any other use is explicitly prohibited.

## Overview

### Installation

Foundry is required to use this repository. See: https://book.getfoundry.sh/getting-started/installation.

### Getting Started 📖

### 1️⃣ Initialize Forge repository

First, initialize a forge repository with the attack template you would like to use. Passing `default` as the branch will initialize a minimal forge repository with the correct dependencies installed. See the [template categories](#template-categories-) below for a list of templates which can be chosen.
```
forge init --template immunefi-team/forge-poc-templates --branch [template]
```

---
### 2️⃣ Download the contract interfaces

You can create your own interface contracts, create an interface automatically with Foundry's [`cast interface`](https://book.getfoundry.sh/reference/cast/cast-interface) commandline tool (a), or download the full source code for contracts for the protocol using Foundry's [`cast etherscan-source`](https://book.getfoundry.sh/reference/cast/cast-etherscan-source) command line tool (b). To use the `cast` commands, define the `ETHERSCAN_API_KEY` environment variable, then call cast with either of the following methods:

#### a. Download the interface (recommended)
Rather than copying the entire smart contract code itself, you can use the Interface feature introduced in Solidity version 0.6.x to define which functions a contract implements. To do so automatically, run the following command in the console:

```sh
cast interface [address] -o src/external/interfaces/IExample.sol -n IExample
```

Foundry automatically creates the interface based on the externally available functions according to the contracts ABI. Then import the newly created interface contract in your PoC:

```js
import "./external/interfaces/IExample.sol";
```
> see also: [ABI to sol](https://gnidan.github.io/abi-to-sol/)


#### b. Download the entire source code
Alternatively, you can download the entire source code from Etherscan like block explorers using the following command:
> ##### *🚨 When downloading source code from deployed contracts, there may be remappings that need to be modified for the source files to compile. Add any necessary remappings to [`remappings.txt`](./remappings.txt).
```sh
cast etherscan-source [address] -d src/external
```

This will download the contracts' entire source code to `src/external`, where you can import any contract interfaces by adding the following to the top of your PoC:
```js
import "./external/ExampleProtocol/ExampleEtherscanContract.sol";
```
Optionally, append `--chain [chain_name]` to specify a chain other than the Ethereum mainnet to download contracts from. **Note:** you will have to update your Etherscan API key when switching between different chains.
<br>


---
### 3️⃣ Write the test
Once you have created your attack contract, import your attack contract into the PoCTest.sol, and modify the `setUp()` to replicate any necessary attack preconditions, such as forking from a network, initializing accounts with certain balances, or creating any other conditions which are necessary for the attack.

Try to keep your setup as **close** to mainnet state as possible. The more the setup differs from the mainnet state, the harder it is for projects to verify your claims. Execute the attack in the `testAttack()` function.

The test should extend the [PoC](./src/PoC.sol) contract, which introduces functionality to automatically snapshot and print account balances before and after a test. Use the modifier `snapshot(address account, IERC20[] tokens)` on the `test*` function to automatically print information such as pre-attack balances, post-attack balances, and profit. Passing a token with `address(0x0)` corresponds to the native token of the chain.

### Running a PoC 🚀

To run a test, use the following command in the console:
```
forge test -vv --match-path test/[test_name]
```

### Environment Variables

| Variable          | Example                                        |
| ----------------- | ---------------------------------------------- |
| ETHERSCAN_API_KEY | [API_KEY]                                      |

## Template Categories 🪲

|       Categorisation       | Branch | Source | Documentation |
| -------------------------- | -------- | ------ | ------------- |
| Default                    | [default](https://github.com/immunefi-team/forge-poc-templates/tree/default)        | | |
| Reentrancy                 | [reentrancy](https://github.com/immunefi-team/forge-poc-templates/tree/reentrancy)        | [Source](./src/reentrancy/Reentrancy.sol)                         | [Readme](./src/reentrancy/README.md)              |
| Flash Loan                 | [flash_loan](https://github.com/immunefi-team/forge-poc-templates/tree/flash_loan)         | [Source](./src/flashloan/FlashLoan.sol)                         | [Readme](./src/flashloan/README.md)               |
| Price Manipulation         | [price_manipulation](https://github.com/immunefi-team/forge-poc-templates/tree/price_manipulation) | [Source](./src/pricemanipulation/PriceManipulation.sol)       | [Readme](./src/pricemanipulation/README.md)       |
| Boilerplate Mocks          | [mocks](./src/mocks/) | [Source](./src/mocks/)       | [Readme](./src/mocks/README.md)       |
<!-- | Forking                    | [Template](./src/ForkingTemplate.sol) | [Source](./src/Forking.sol)                       | [Test](./test/Forking.t.sol)            |
| NFTX Loan                  | [Template](./src/NFTXLoanTemplate.sol) | [Source](./src/NFTXLoan.sol)                      | [Test](./test/NFTXLoan.t.sol)           |
| Uninitialized Proxy        | [Template](./src/UninitializedProxyTemplate.sol) | [Source](./src/UninitializedProxy.sol)            | [Test](./test/UninitializedProxy.t.sol) | -->

## Foundry Concepts

 - [Foundry](https://book.getfoundry.sh/)

## PoCs from our community ✨

 - [Hundred Finance Hack](https://medium.com/immunefi/a-poc-of-the-hundred-finance-heist-4121f23a098) by [@hephyrius](https://twitter.com/hephyrius)
 - [Omni Protocol Hack](https://medium.com/immunefi/hack-analysis-omni-protocol-july-2022-2d35091a0109) by [@realgmhacker](https://twitter.com/realgmhacker)
 - [Euler Exploit PoC](https://github.com/iphelix/euler-exploit-poc) by [@iphelix](https://twitter.com/_iphelix)
 - [DFX Finance Bugfix Review](./pocs/DFXFinanceBugfixReview.sol) by [@unsafe_call](https://twitter.com/unsafe_call)

## Contribute 📝

We sincerely appreciate contributions to Immunefi's templates. Please take the time to review the [contribution guidelines](.github/CONTRIBUTING.md) and [code of conduct](.github/CODE_OF_CONDUCT.md) to ensure your contributions are merged as soon as possible.

## Contributors
* [@unsafe_call](https://twitter.com/unsafe_call)
* [@Omikomikomik](https://twitter.com/omikomikomik)
* [@ArbazKiraak](https://twitter.com/ArbazKiraak)
* [@AdrianHetman](https://twitter.com/adrianhetman)
* [@Pep1nn](https://twitter.com/Pep1nn)
* [@realgmhacker](https://twitter.com/realgmhacker)
* [@_iphelix](https://twitter.com/_iphelix)
* [0xlead](https://github.com/0xlead)
* [@infosec_us_team](https://twitter.com/infosec_us_team)


## All set!

If you have any questions, feel free to post them to https://github.com/immunefi-team/forge-poc-templates/issues.

Finally, if you're looking to collaborate and want to find easy tasks to start, look at the issues we marked as ["Good first issue"](https://github.com/immunefi-team/forge-poc-templates/labels/good%20first%20issue).

Thanks for your time and code!
