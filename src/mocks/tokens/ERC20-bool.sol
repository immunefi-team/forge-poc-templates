pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";
import {ERC20Base} from "./base/ERC20Base.sol";

contract ERC20Bool is ERC20Base {
    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;

        emit Transfer(address(0), msg.sender, _initialSupply);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        if (balanceOf[msg.sender] >= amount && balanceOf[to] + amount >= balanceOf[to]) {
            balanceOf[to] += amount;
            balanceOf[msg.sender] -= amount;
            emit Transfer(msg.sender, to, amount);
            return true;
        } else {
            return false;
        }
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        if (
            balanceOf[from] >= amount && allowance[from][msg.sender] >= amount
                && balanceOf[to] + amount >= balanceOf[to]
        ) {
            balanceOf[to] += amount;
            balanceOf[from] -= amount;
            emit Transfer(from, to, amount);
            allowance[from][msg.sender] -= amount;
            emit Approval(from, msg.sender, allowance[from][msg.sender]);
            return true;
        } else {
            return false;
        }
    }
}
