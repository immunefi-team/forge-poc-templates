pragma solidity ^0.8.0;

import {AAVEV1FlashLoan} from "./lib/AAVEFlashLoan.sol";
import {EulerFlashLoan} from "./lib/EulerFlashLoan.sol";

enum FlashLoanProviders {
    AAVEV1,
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
        if (flp == FlashLoanProviders.AAVEV1) {
            AAVEV1FlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.BALANCER) {

        } else if (flp == FlashLoanProviders.EULER) {
            EulerFlashLoan.takeFlashLoan(token, amount);
        }
    }

    /**
     * @dev Pay back the flash loan to the specified flashloan provider
     * @param flp The flashloan provider to pay the loan back to
     */
    function payFlashLoan(FlashLoanProviders flp) internal {
        if (flp == FlashLoanProviders.AAVEV1) {
            AAVEV1FlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.BALANCER) {

        } else if (flp == FlashLoanProviders.EULER) {
            EulerFlashLoan.payFlashLoan(msg.data);
        }
    }

    /**
     * @dev Gets the bytes4 function selector for the intended flash loan callback
     * @param flp The flashloan provider to get the callback selector of
     */
    function callbackFunctionSelector(FlashLoanProviders flp) internal returns (bytes4) {
        if(flp == FlashLoanProviders.AAVEV1) {
            return AAVEV1FlashLoan.CALLBACK_SELECTOR;
        }
    }
}
