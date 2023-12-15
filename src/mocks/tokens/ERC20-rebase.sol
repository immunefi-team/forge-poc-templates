pragma solidity ^0.8.0;

import "forge-std/interfaces/IERC20.sol";
import {ERC20Base} from "./base/ERC20Base.sol";

import "forge-std/Test.sol";

contract ERC20Rebase is ERC20Base, Test {
    uint256 public lastRebaseTimestamp;
    uint256 public rebaseInterval = 1 minutes;
    uint256 public rebaseAmt = 5;

    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply,
        uint256 _rebaseInterval,
        uint256 _rebaseAmt
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply;
        balanceOf[msg.sender] = _initialSupply;

        lastRebaseTimestamp = block.timestamp;
        rebaseInterval = _rebaseInterval;
        rebaseAmt = _rebaseAmt;

        emit Transfer(address(0), msg.sender, _initialSupply);
    }

    function setRebaseAmount(uint256 _rebaseAmt) public {
        rebaseAmt = _rebaseAmt;
    }

    function setRebaseInterval(uint256 _rebaseInterval) public {
        rebaseInterval = _rebaseInterval;
    }

    modifier rebase() {
        uint256 timeSinceLastRebase = block.timestamp - lastRebaseTimestamp;
        if (timeSinceLastRebase >= rebaseInterval) {
            uint256 rebaseMultiplier = timeSinceLastRebase / rebaseInterval;
            totalSupply += rebaseAmt * rebaseMultiplier;
            balanceOf[msg.sender] += rebaseAmt * rebaseMultiplier;
            lastRebaseTimestamp += rebaseInterval * rebaseMultiplier;
        }
        _;
    }

    function transfer(address to, uint256 amount) public override rebase returns (bool) {
        super.transfer(to, amount);
    }

    function transferFrom(address from, address to, uint256 amount) public override rebase returns (bool) {
        super.transferFrom(from, to, amount);
    }
}
