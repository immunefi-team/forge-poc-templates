// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "./tokens/Tokens.sol";
import "./log/Log.sol";

struct TokenBalance {
    IERC20 token;
    int256 amount;
}

contract PoC is Test, Tokens, Log {
    // For snapshotting users' balances
    mapping(address => TokenBalance[][]) public tokensBalance;
    // For resolving addresses to aliases
    mapping(address => string) public names;
    // Level of information to print
    uint8 logLevel;

    /**
     * @notice snapshot the balance of the attacker for the specified tokens
     * @param _user the user to snapshot the balance of
     * @param _tokens the list of tokens to snapshot the balance of
     * @return index the index of the balance snapshot
     */
    function snapshotAndPrint(address _user, IERC20[] memory _tokens) public returns (uint256 index) {
        TokenBalance[] memory tokenBalances = new TokenBalance[](_tokens.length);
        index = tokensBalance[_user].length;
        tokensBalance[_user].push();
        for (uint256 i = 0; i < _tokens.length; i++) {
            uint256 tokenBalance = address(_tokens[i]) != address(0x0) ? _tokens[i].balanceOf(_user) : _user.balance;
            require(tokenBalance <= uint256(type(int256).max), "PoC: balance too large");
            tokenBalances[i].token = _tokens[i];
            tokenBalances[i].amount = int256(tokenBalance);
            tokensBalance[_user][index].push(tokenBalances[i]);
        }
        printBalance(_user, index);
    }

    /**
     * @notice snapshot the balance of the attacker for the specified tokens
     * @param _user the user to snapshot the balance of
     * @param _tokens the list of tokens to snapshot the balance of
     * @return tokenBalances the list of token balances
     */
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

    /**
     * @notice snapshot the balance of the attacker for the specified tokens and amounts
     * @param _user the user to snapshot the balance of
     * @param _tokens the list of tokens to snapshot the balance of
     * @param _amounts the list of amounts to snapshot the balance of
     * @return tokenBalances the list of token balances
     */
    function snapshotBalance(address _user, IERC20[] memory _tokens, uint256[] memory _amounts)
        public
        returns (TokenBalance[] memory tokenBalances)
    {
        tokenBalances = new TokenBalance[](_tokens.length);
        uint256 index = tokensBalance[_user].length;
        tokensBalance[_user].push();
        for (uint256 i = 0; i < _tokens.length; i++) {
            uint256 tokenBalance = _amounts[i];
            require(tokenBalance <= uint256(type(int256).max), "PoC: balance too large");
            tokenBalances[i].token = _tokens[i];
            tokenBalances[i].amount = int256(tokenBalance);
            tokensBalance[_user][index].push(tokenBalances[i]);
        }
    }

    /**
     * @notice snapshot the balance of the attacker for the specified tokens
     * @param _user the user to snapshot the balance of
     * @param _tokens the list of tokens to snapshot the balance of
     */
    modifier snapshot(address _user, IERC20[] memory _tokens) {
        snapshotAndPrint(_user, _tokens);
        _;
        snapshotAndPrint(_user, _tokens);
        printProfit(address(_user));
    }

    /**
     * @notice prints the balance of the user for the specified tokens
     * @param _user the user to print the balance of
     * @param _index the index of the balance snapshot to print
     */
    function printBalance(address _user, uint256 _index) public view {
        string memory resolvedAddress = _resolveAddress(_user);
        if (logLevel == 1) {
            _log("~~~ Balance of [%s] at block #%s", resolvedAddress, block.number);
            _log("-----------------------------------------------------------------------------------------");
            _log("             Token address                    |       Symbol  |       Balance");
            _log("-----------------------------------------------------------------------------------------");
        }
        for (uint256 j = 0; j < tokensBalance[_user][_index].length; j++) {
            uint256 balance = uint256(tokensBalance[_user][_index][j].amount);

            // Normalize to token decimals
            uint256 d = tokensBalance[_user][_index][j].token != IERC20(address(0x0))
                ? tokensBalance[_user][_index][j].token.decimals()
                : 18;
            uint256 integer_part = balance / (10 ** d);
            string memory fractional_part_string;
            {
                uint256 fractional_part = balance % (10 ** d);
                string memory fractional_part_leading_zeros;

                uint256 leading_zeros = d - (log10(fractional_part) + 1);
                for (uint256 i = 0; i < leading_zeros; i++) {
                    fractional_part_leading_zeros = string.concat(fractional_part_leading_zeros, "0");
                }

                fractional_part_string = string.concat(fractional_part_leading_zeros, toString(fractional_part));
            }

            // Get token symbol
            string memory symbol = tokensBalance[_user][_index][j].token != IERC20(address(0x0))
                ? tokensBalance[_user][_index][j].token.symbol()
                : "NATIVE";

            // Generate template string
            string memory template;
            if (logLevel == 1) {
                template = string.concat("%s\t|\t", symbol, "\t|\t%s.%s");
                _log(template, address(tokensBalance[_user][_index][j].token), integer_part, fractional_part_string);
            } else if (logLevel == 0) {
                template = string.concat("--- ", symbol, " balance of [%s]:\t%s.%s", " ---");
                _log(template, resolvedAddress, integer_part, fractional_part_string);
            }
        }
        _log();
    }

    /**
     * @notice prints the profit of the user for the specified tokens
     * @param _user the user to print the profit of
     */
    function printProfit(address _user) public view {
        string memory resolvedAddress = _resolveAddress(_user);
        _log("~~~ Profit for [%s]", resolvedAddress);
        _log("-----------------------------------------------------------------------------------------");
        _log("             Token address                    |       Symbol  |       Profit");
        _log("-----------------------------------------------------------------------------------------");
        for (uint256 j = 0; j < tokensBalance[_user][0].length; j++) {
            int256 profit = tokensBalance[_user][tokensBalance[_user].length - 1][j].amount
                - int256(tokensBalance[_user][0][j].amount);

            // Convert to absolute value
            uint256 abs_profit = profit < 0 ? uint256(-profit) : uint256(profit);
            string memory sign = profit < 0 ? "-" : "";

            // Normalize to token decimals
            uint256 d = tokensBalance[_user][0][j].token != IERC20(address(0x0))
                ? tokensBalance[_user][0][j].token.decimals()
                : 18;
            uint256 integer_part = abs_profit / (10 ** d);
            string memory fractional_part_string;
            {
                uint256 fractional_part = abs_profit % (10 ** d);
                string memory fractional_part_leading_zeros;

                uint256 leading_zeros = d - (log10(fractional_part) + 1);
                for (uint256 i = 0; i < leading_zeros; i++) {
                    fractional_part_leading_zeros = string.concat(fractional_part_leading_zeros, "0");
                }

                fractional_part_string = string.concat(fractional_part_leading_zeros, toString(fractional_part));
            }

            // Get token symbol
            string memory symbol = tokensBalance[_user][0][j].token != IERC20(address(0x0))
                ? tokensBalance[_user][0][j].token.symbol()
                : "NATIVE";

            // Generate template string
            string memory template = string.concat("%s\t|\t", symbol, "\t|\t", sign, "%s.%s");

            _log(template, address(tokensBalance[_user][0][j].token), integer_part, fractional_part_string);
        }
        _log();
    }

    /**
     * @notice sets the alias for an address
     * @param _user the address to set the alias for
     * @param _alias the alias to set
     */
    function setAlias(address _user, string memory _alias) public {
        names[_user] = _alias;
    }

    /**
     * @notice sets the log level
     * @param _logLevel the log level to set
     */
    function setLogLevel(uint8 _logLevel) public {
        logLevel = _logLevel;
    }

    /**
     * @notice resolves the address to a name if it has one
     * @param _user the address to resolve
     * @return the resolved alias
     */
    function _resolveAddress(address _user) internal view returns (string memory) {
        return bytes(names[_user]).length != 0 ? names[_user] : toAsciiString(_user);
    }

    /**
     * @notice converts an address to a string
     * @param x the address to convert
     * @return the string representation of the address
     */
    function toAsciiString(address x) internal pure returns (string memory) {
        bytes memory s = new bytes(40);
        for (uint256 i = 0; i < 20; i++) {
            bytes1 b = bytes1(uint8(uint256(uint160(x)) / (2 ** (8 * (19 - i)))));
            bytes1 hi = bytes1(uint8(b) / 16);
            bytes1 lo = bytes1(uint8(b) - 16 * uint8(hi));
            s[2 * i] = char(hi);
            s[2 * i + 1] = char(lo);
        }
        return string.concat("0x", string(s));
    }

    /**
     * @notice converts a byte to a char
     * @param b the byte to convert
     * @return the char representation of the byte
     */
    function char(bytes1 b) internal pure returns (bytes1) {
        if (uint8(b) < 10) return bytes1(uint8(b) + 0x30);
        else return bytes1(uint8(b) + 0x57);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     * @notice Pulled from OpenZeppelin 5.0.2 Strings.sol library
     */
    bytes16 private constant HEX_DIGITS = "0123456789abcdef";

    function toString(uint256 value) internal pure returns (string memory) {
        unchecked {
            uint256 length = log10(value) + 1;
            string memory buffer = new string(length);
            uint256 ptr;
            /// @solidity memory-safe-assembly
            assembly {
                ptr := add(buffer, add(32, length))
            }
            while (true) {
                ptr--;
                /// @solidity memory-safe-assembly
                assembly {
                    mstore8(ptr, byte(mod(value, 10), HEX_DIGITS))
                }
                value /= 10;
                if (value == 0) break;
            }
            return buffer;
        }
    }

    /**
     * @dev Return the log in base 10 of a positive value rounded towards zero.
     * @notice Pulled from OpenZeppelin 5.0.2 Math.sol library
     * Returns 0 if given 0.
     */
    function log10(uint256 value) internal pure returns (uint256) {
        uint256 result = 0;
        unchecked {
            if (value >= 10 ** 64) {
                value /= 10 ** 64;
                result += 64;
            }
            if (value >= 10 ** 32) {
                value /= 10 ** 32;
                result += 32;
            }
            if (value >= 10 ** 16) {
                value /= 10 ** 16;
                result += 16;
            }
            if (value >= 10 ** 8) {
                value /= 10 ** 8;
                result += 8;
            }
            if (value >= 10 ** 4) {
                value /= 10 ** 4;
                result += 4;
            }
            if (value >= 10 ** 2) {
                value /= 10 ** 2;
                result += 2;
            }
            if (value >= 10 ** 1) {
                result += 1;
            }
        }
        return result;
    }
}
