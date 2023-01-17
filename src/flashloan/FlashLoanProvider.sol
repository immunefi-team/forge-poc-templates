pragma solidity ^0.8.0;

import {AAVEFlashloan} from "./lib/AAVEFlashloan.sol";

enum FlashloanProviders {
    AAVE,
    BALANCER,
    EULER
}

library FlashloanProvider {
    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider and token
     * @param flp The flashloan provider to take the loan from
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(FlashloanProviders flp, address token, uint256 amount) internal {
        if (flp == FlashloanProviders.AAVE) {
            AAVEFlashloan.takeFlashLoan(token, amount);
        } else if (flp == FlashloanProviders.BALANCER) {} else if (flp == FlashloanProviders.BALANCER) {}
    }

    /**
     * @dev Pay back the flash loan to the specified flashloan provider
     * @param flp The flashloan provider to pay the loan back to
     */
    function payFlashLoan(FlashloanProviders flp) internal {
        if (flp == FlashloanProviders.AAVE) {
            AAVEFlashloan.payFlashLoan(msg.data);
        } else if (flp == FlashloanProviders.BALANCER) {} else if (flp == FlashloanProviders.BALANCER) {}
    }
}
