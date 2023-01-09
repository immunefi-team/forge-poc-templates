# Immunefi PoC Templates

This is a collaborative repository that aims to provide reusable and easily modifiable PoC examples for a variety of attacks. This will increase quality of submissions and allow whitehats an easier, faster way to create PoCs and verify their claims.

## Overview

### Installation

A Foundry installation is required to use this repository. See https://book.getfoundry.sh/getting-started/installation.

### Getting Started 📖

Pick a PoC [template](#template-categories-) and open the corresponding source contract. Within the source contract, there will be comments describing how you can modify the PoC to fit your vulnerability.

Once you have completed your attack contract, navigate to the corresponding [test](./test) file and modify the setup to replicate any necessary attack preconditions, such as forking from a network, initializing accounts with certain balances, or any other conditions which are necessary for the attack. Try to keep your setup as **close** to mainnet state as possible. The more setup that is done, the harder it is for projects to verify your claims.

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

|       Categorisation       | Source | Test |
| -------------------------- | ------------------------------------------------- | --------------------------------------- |
| Reentrancy                 | [Source](./src/Reentrancy/Reentrancy.sol)         | [Test](./test/Reentrancy.t.sol)         |
<!-- | Forking                    | [Source](./src/Forking.sol)                       | [Test](./test/Forking.t.sol)            |
| Token Balance Manipulation | [Source](./src/TokenBalance.sol)                  | [Test](./test/TokenBalance.t.sol)       |
| Flashloan                  | [Source](./src/Flashloan.sol)                     | [Test](./test/Flashloan.t.sol)          |
| Price Manipulation         | [Source](./src/PriceManipulation.sol)             | [Test](./test/PriceManipulation.t.sol)  |
| NFTX Loan                  | [Source](./src/NFTXLoan.sol)                      | [Test](./test/NFTXLoan.t.sol)           |
| Uninitialized Proxy        | [Source](./src/UninitializedProxy.sol)            | [Test](./test/UninitializedProxy.t.sol) | -->

## Foundry Concepts

 - [Foundry](https://book.getfoundry.sh/)

## PoCs from our community ✨

 - [Hundred Finance Hack](https://www.github.com) by [@example_hacker](https://twitter.com)

## Contribute 📝

We sincerely appreciate contributions to Immunefi's templates. Please take the time to review the guidelines below to ensure your contributions are merged as soon as possible and follow the [code of conduct](./CODE_OF_CONDUCT.md). The following guidelines were adapted from OpenZeppelin's contribution guidelines.

### Contribution Guidelines

We would like to keep our templates as modular as possible and provide generic tooling which will get our whitehats up and running with PoCs for vulnerabilities as quickly as possible. This means templates must be neat and concise.

### Creating a PoC Template

To create a PoC template, be sure to follow the same pattern as existing templates. Create an attack contract which exists in ./src and a corresponding test in ./test. The name of both files should match, and be a short one or two word description of the vulnerability type used in the attack.

In addition to the attack contract and test file, the [Template Categories](#template-categories-) needs to be updated with the corresponding template.

In order to be consistent with all the other Solidity projects, we follow the
[official recommendations documented in the Solidity style guide](http://solidity.readthedocs.io/en/latest/style-guide.html).

Any exception or additions specific to our project are documented below.

### Creating Pull Requests (PRs)

As a contributor, you are expected to fork this repository, work on your own fork and then submit pull requests. The pull requests will be reviewed and eventually merged into the main repo. See ["Fork-a-Repo"](https://help.github.com/articles/fork-a-repo/) for how this works.

### A typical workflow

1) Make sure your fork is up to date with the main repository:

```
cd forge-poc-templates
git remote add upstream https://github.com/immunefi-team/forge-poc-templates.git
git fetch upstream
git pull --rebase upstream master
```
NOTE: The directory `forge-poc-templates` represents your fork's local copy.

2) Branch out from `main` into `template/some-attack-type#123`:
(Postfixing #123 will associate your PR with the issue #123)
```
git checkout -b template/some-attack-type#123
```

3) Make your changes, add your files, commit, and push to your fork.

```
git add SomeFile.sol
git commit "Create new attack template #123"
git push origin template/some-attack-type#123
```

4) Run tests, linter, etc. This can be done by running local continuous integration and make sure it passes.

```bash
forge test -vv
```

5) Go to [github.com/immunefi-team/forge-poc-templates](https://github.com/immunefi-team/forge-poc-templates) in your web browser and issue a new pull request.

*IMPORTANT* Read the PR template very carefully and make sure to follow all the instructions. These instructions
refer to some very important conditions that your PR must meet in order to be accepted, such as making sure that all tests pass, JS linting tests pass, Solidity linting tests pass, etc.

6) Maintainers will review your code and possibly ask for changes before your code is pulled in to the main repository. We'll check that all tests pass, review the coding style, and check for general code correctness. If everything is OK, we'll merge your pull request and your code will be part of Immunefi's templates.

*IMPORTANT* Please pay attention to the maintainer's feedback, since it's a necessary step to keep up with the standards Immunefi attains to.

## All set!

If you have any questions, feel free to post them to https://github.com/immunefi-team/forge-poc-templates/issues.

Finally, if you're looking to collaborate and want to find easy tasks to start, look at the issues we marked as ["Good first issue"](https://github.com/immunefi-team/forge-poc-templates/labels/good%20first%20issue).

Thanks for your time and code!