pragma solidity ^0.8.0;

contract Proxy {
    address public implementation;
    address public owner;

    event Upgraded(address implementation);

    modifier onlyImplementation() {
        require(msg.sender == implementation, "Proxy: only implementation allowed");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Proxy: only owner allowed");
        _;
    }

    constructor(address initialImplementation) {
        implementation = initialImplementation;
        owner = msg.sender;
    }

    function upgradeTo(address newImplementation) external onlyOwner {
        require(newImplementation != address(0), "Proxy: Cannot upgrade to the zero address");
        require(newImplementation != implementation, "Proxy: Cannot upgrade to the same implementation");

        implementation = newImplementation;
        emit Upgraded(newImplementation);
    }

    fallback() external payable {
        address _impl = implementation;
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}
