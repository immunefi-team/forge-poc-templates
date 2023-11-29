pragma solidity ^0.8.0;

contract returnBomb {
    fallback() external {
        assembly {
            revert(1, 10000000)
        }
    }
}
