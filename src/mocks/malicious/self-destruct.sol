pragma solidity ^0.8.0;

// Deprecation of selfdestruct
// https://soliditylang.org/blog/2023/02/01/solidity-0.8.18-release-announcement/

contract selfDestruct {
    constructor() {}

    function attack(address _contractAddr) public {
        selfdestruct(payable(_contractAddr));
    }

    function destruct() external {
        selfdestruct(payable(msg.sender));
    }
}
