# Immunefi PoC Templates

This is a collaborative repository that aims to provide reusable and easily modifiable PoC examples for a variety of attacks. This will increase quality of submissions and allow whitehats an easier, faster way to create PoCs and verify their claims.

## Overview

### Installation

A Foundry installation is required to use this repository. See https://book.getfoundry.sh/getting-started/installation.

### Getting Started 📖

1️⃣ First set up the interfaces for the protocol you will be creating a PoC for. You can create your own interface contracts, or download the contracts for the protocol using Foundry's [`cast etherscan-source`](https://book.getfoundry.sh/reference/cast/cast-etherscan-source) command line tool. Define the `ETHERSCAN_API_KEY` environment variable, then call
```
cast etherscan-source [address] -d src/external
```
This will download the contracts source code to `src/external` where you can simply import any contract interfaces by adding the following to the top of your PoC.
> ##### *🚨 When downloading source code from deployed contracts, there may be remappings that need to be modified for the source files to compile. Add any necessary remappings to [`remappings.txt`](./remappings.txt).
```
import "./external/ExampleProtocol/ExampleEtherscanContract.sol"
```
Optionally, append `--chain [chain_name]` to specify a chain other than Ethereum mainnet to download contracts from. **Note:** You will have to update your Etherscan API key when switching between different chains.
<br>

2️⃣ Pick a PoC [template](#template-categories-) and modify the template file which extends* from the corresponding source contract. Within the source contract, there will be comments describing how you can modify the PoC to fit your vulnerability. 

> #####  *🚨 When extending from an abstract contract, there will be functions which must be defined. Implement any undefined functions with your attack.
<br>

3️⃣ Once you have completed your attack contract, navigate to the corresponding [test](./test) file, import your attack contract, and modify the `setUp()` to replicate any necessary attack preconditions, such as forking from a network, initializing accounts with certain balances, or any other conditions which are necessary for the attack. Try to keep your setup as **close** to mainnet state as possible. The more setup that is done, the harder it is for projects to verify your claims.

### Running a PoC 🚀

To run a template, run the following in the console:
```
forge test -vv --match-path test/[test_name]
```

### Environment Variables

| Variable          | Example                                        |
| ----------------- | ---------------------------------------------- |
| RPC_URL           | https://eth-mainnet.alchemyapi.io/v2/[API_KEY] |
| ETHERSCAN_API_KEY | [API_KEY]                                      |

## Template Categories 🪲

|       Categorisation       | Template | Source | Test |
| -------------------------- | -------- |  ------------------------------------------------- | --------------------------------------- |
| Reentrancy                 | [Template](./src/ReentrancyTemplate.sol) | [Source](./src/reentrancy/Reentrancy.sol)         | [Test](./test/Reentrancy.t.sol)         |
| Token Balance Manipulation | [Template](./src/ReentrancyTemplate.sol) | [Source](./src/tokens/Tokens.sol)                 | [Test](./test/Tokens.t.sol)             |
| Flash Loan                 | [Template](./src/FlashloanTemplate.sol)  | [Source](./src/flashloan/Flashloan.sol)                     | [Test](./test/Flashloan.t.sol)          |
<!-- | Forking                    | [Template](./src/ForkingTemplate.sol) | [Source](./src/Forking.sol)                       | [Test](./test/Forking.t.sol)            |
| Price Manipulation         | [Template](./src/PriceManipulationTemplate.sol) | [Source](./src/PriceManipulation.sol)             | [Test](./test/PriceManipulation.t.sol)  |
| NFTX Loan                  | [Template](./src/NFTXLoanTemplate.sol) | [Source](./src/NFTXLoan.sol)                      | [Test](./test/NFTXLoan.t.sol)           |
| Uninitialized Proxy        | [Template](./src/UninitializedProxyTemplate.sol) | [Source](./src/UninitializedProxy.sol)            | [Test](./test/UninitializedProxy.t.sol) | -->

## Foundry Concepts

 - [Foundry](https://book.getfoundry.sh/)

## PoCs from our community ✨

 - [Hundred Finance Hack](https://www.github.com) by [@example_hacker](https://twitter.com)

## Contribute 📝

We sincerely appreciate contributions to Immunefi's templates. Please take the time to review the [contribution guidelines](.github/CONTRIBUTING.md) to ensure your contributions are merged as soon as possible and follow the [code of conduct](.github/CODE_OF_CONDUCT.md).

## All set!

If you have any questions, feel free to post them to https://github.com/immunefi-team/forge-poc-templates/issues.

Finally, if you're looking to collaborate and want to find easy tasks to start, look at the issues we marked as ["Good first issue"](https://github.com/immunefi-team/forge-poc-templates/labels/good%20first%20issue).

Thanks for your time and code!