pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";
import {ERC20Base} from "./base/ERC20Base.sol";

contract ERC20FeeTransfer is ERC20Base {
    uint256 public fee;

    constructor(string memory _name, string memory _symbol, uint8 _decimals, uint256 _initialSupply, uint256 _fee) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply;
        fee = _fee;
        balanceOf[msg.sender] = _initialSupply;

        emit Transfer(address(0), msg.sender, _initialSupply);
    }

    function setFee(uint256 _fee) public {
        fee = _fee;
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        require(balanceOf[msg.sender] >= amount, "ERC20Fee: Insufficient-balance");

        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount - fee;
        balanceOf[address(0)] += fee;

        emit Transfer(msg.sender, to, amount - fee);
        emit Transfer(msg.sender, address(0), fee);

        return true;
    }

    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        require(balanceOf[from] >= amount, "ERC20Fee: Insufficient-balance");
        if (from != msg.sender && allowance[from][msg.sender] != type(uint256).max) {
            require(allowance[from][msg.sender] >= amount, "ERC20Fee: Insufficient-balance");
            allowance[from][msg.sender] -= amount;
        }

        balanceOf[from] -= amount;
        balanceOf[to] += amount - fee;
        balanceOf[address(0)] += fee;

        emit Transfer(from, to, amount - fee);
        emit Transfer(from, address(0), fee);

        return true;
    }
}
