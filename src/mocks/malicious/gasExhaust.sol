pragma solidity ^0.8.0;

contract gasExhaust {
    uint256 counter;
    uint256 gasConsumeLimit;

    function setGasConsumeLimit(uint256 _gasConsume) public {
        gasConsumeLimit = _gasConsume;
    }

    fallback() external {
        while (gasleft() > gasConsumeLimit) {
            counter++;
        }
    }
}
