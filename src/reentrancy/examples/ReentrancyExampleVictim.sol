pragma solidity ^0.8.13;

contract ReentrancyExampleVictim {
    mapping(address => uint256) balance;

    function deposit() external payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw() external {
        (bool success,) = msg.sender.call{value: balance[msg.sender]}("");
        require(success, "ETH transfer failed");
        balance[msg.sender] = 0;
    }
}
