pragma solidity ^0.8.0;

import {AAVEFlashLoan} from "./lib/AAVEFlashLoan.sol";

enum FlashLoanProviders {
    AAVE,
    BALANCER,
    EULER
}

library FlashLoanProvider {
    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider and token
     * @param flp The flashloan provider to take the loan from
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, address token, uint256 amount) internal {
        if (flp == FlashLoanProviders.AAVE) {
            AAVEFlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.BALANCER) {} else if (flp == FlashLoanProviders.EULER) {}
    }

    /**
     * @dev Pay back the flash loan to the specified flashloan provider
     * @param flp The flashloan provider to pay the loan back to
     */
    function payFlashLoan(FlashLoanProviders flp) internal {
        if (flp == FlashLoanProviders.AAVE) {
            AAVEFlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.BALANCER) {} else if (flp == FlashLoanProviders.EULER) {}
    }
}
