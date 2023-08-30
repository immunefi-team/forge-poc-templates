// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import {Tokens, IERC20} from "./tokens/Tokens.sol";

struct TokenBalance {
    IERC20 token;
    int256 amount;
}

contract PoC is Test, Tokens {
    mapping(address => TokenBalance[][]) public tokensBalance;

    /// @notice snapshot the balance of the attacker for the specified tokens
    /// @param _user the user to snapshot the balance of
    /// @param _tokens the list of tokens to snapshot the balance of
    /// @return tokenBalances the list of token balances
    function snapshotBalance(address _user, IERC20[] memory _tokens)
        public
        returns (TokenBalance[] memory tokenBalances)
    {
        tokenBalances = new TokenBalance[](_tokens.length);
        uint256 index = tokensBalance[_user].length;
        tokensBalance[_user].push();
        for (uint256 i = 0; i < _tokens.length; i++) {
            uint256 tokenBalance = address(_tokens[i]) != address(0x0) ? _tokens[i].balanceOf(_user) : _user.balance;
            require(tokenBalance <= uint256(type(int256).max), "PoC: balance too large");
            tokenBalances[i].token = _tokens[i];
            tokenBalances[i].amount = int256(tokenBalance);
            tokensBalance[_user][index].push(tokenBalances[i]);
        }
    }

    /// @notice snapshot the balance of the attacker for the specified tokens
    /// @param _user the user to snapshot the balance of
    /// @param _tokens the list of tokens to snapshot the balance of
    modifier snapshot(address _user, IERC20[] memory _tokens) {
        snapshotBalance(_user, _tokens);
        printBalance(_user, 0);
        _;
        snapshotBalance(_user, _tokens);
        printBalance(_user, tokensBalance[_user].length - 1);
        printProfit(address(_user));
    }

    /// @notice prints the balance of the user for the specified tokens
    /// @param _user the user to print the balance of
    /// @param _index the index of the balance snapshot to print
    function printBalance(address _user, uint256 _index) public view {
        console.log("Balance of [%s] at block #%s", _user, block.number);
        console.log("---------------------------------");
        console.log(" SYM | Balance | TOKEN_ADDRESS");
        console.log("---------------------------------");
        for (uint256 j = 0; j < tokensBalance[_user][_index].length; j++) {
            uint256 balance = uint256(tokensBalance[_user][_index][j].amount);
            // Normalize to token decimals
            balance = balance / 10 ** tokensBalance[_user][_index][j].token.decimals();
            string memory symbol = tokensBalance[_user][_index][j].token.symbol();
            console.log("%s | %s | %s", symbol, balance, address(tokensBalance[_user][0][j].token));
        }
        console.log();
    }

    /// @notice prints the profit of the user for the specified tokens
    /// @param _user the user to print the profit of
    function printProfit(address _user) public view {
        console.log("Profit for [%s]", _user);
        console.log("---------------------------------");
        console.log(" SYM | PROFIT | TOKEN_ADDRESS");
        console.log("---------------------------------");
        for (uint256 j = 0; j < tokensBalance[_user][0].length; j++) {
            int256 profit = tokensBalance[_user][tokensBalance[_user].length - 1][j].amount
                - int256(tokensBalance[_user][0][j].amount);
            uint256 abs_profit = profit < 0 ? uint256(-profit) : uint256(profit);
            // Normalize to token decimals
            abs_profit = abs_profit / 10 ** tokensBalance[_user][0][j].token.decimals();
            string memory sign = profit < 0 ? "-" : "";
            string memory symbol = tokensBalance[_user][0][j].token.symbol();
            string memory template = string.concat(symbol, " | %s%s | %s");
            console.log(template, sign, abs_profit, address(tokensBalance[_user][0][j].token));
        }
        console.log();
    }
}
