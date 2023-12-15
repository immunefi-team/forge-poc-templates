pragma solidity ^0.8.0;

/*

The returnDataSize value needs careful calibration: it should not be so high that it depletes all the gas, causing a revert, nor should it be so low that the function consumes all the gas yet still returns the data successfully.

Our goal is to determine an optimal median value for returnDataSize that will ensure the outer call reverts as intended.
*/

contract returnBomb {
    uint128 public returnDataSize = 10000; // by default

    function setReturnDataSize(uint128 _returnDataSize) external {
        returnDataSize = _returnDataSize;
    }

    fallback() external {
        assembly {
            revert(0, returnDataSize.slot)
        }
    }
}
