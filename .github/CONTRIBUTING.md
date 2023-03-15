### Contribution Guidelines

We would like to keep our templates as modular as possible and provide generic tooling which will get our whitehats up and running with PoCs for vulnerabilities as quickly as possible. This means templates must be neat and concise. The following guidelines were adapted from OpenZeppelin's contribution guidelines.

### Creating a PoC Template

To create a PoC template, be sure to follow the same pattern as existing templates. Create an abstract attack contract which exists in ./src and a corresponding test in ./test. The name of both files should match, and be a short one or two word description of the vulnerability type used in the attack.

In addition to the abstract attack contract which can be extended and test file, the [Template Categories](#template-categories-) needs to be updated with the corresponding template whitehats can modify to implement their own attack.

In order to be consistent with all the other Solidity projects, we follow the
[official recommendations documented in the Solidity style guide](http://solidity.readthedocs.io/en/latest/style-guide.html).

Any exception or additions specific to our project are documented below.

### Creating Pull Requests (PRs)

As a contributor, you are expected to fork this repository, work on your own fork and then submit pull requests. The pull requests will be reviewed and eventually merged into the main repo. See ["Fork-a-Repo"](https://help.github.com/articles/fork-a-repo/) for how this works. Additionally, contributors are required to sign a [CLA](./CLA.md) before their changes can be reviewed and accepted.

### A typical workflow

1) Make sure your fork is up to date with the main repository:

```
cd forge-poc-templates
git remote add upstream https://github.com/immunefi-team/forge-poc-templates.git
git fetch upstream
git pull --rebase upstream main
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
refer to some very important conditions that your PR must meet in order to be accepted, such as making sure that all tests pass, Solidity linting tests pass, etc.

6) Sign CLA available [here](https://app.hellosign.com/s/3c0FRG89)

7) Maintainers will review your code and possibly ask for changes before your code is pulled in to the main repository. We'll check that all tests pass, review the coding style, and check for general code correctness. If everything is OK, we'll merge your pull request and your code will be part of Immunefi's templates.

*IMPORTANT* Please pay attention to the maintainer's feedback, since it's a necessary step to keep up with the standards Immunefi attains to.
