pragma solidity ^0.8.0;

import {AAVEV1FlashLoan} from "./lib/AAVEV1FlashLoan.sol";
import {EulerFlashLoan} from "./lib/EulerFlashLoan.sol";
import {BalancerFlashLoan} from "./lib/BalancerFlashLoan.sol";
import {MakerDAOFlashLoan} from "./lib/MakerDAOFlashLoan.sol";

enum FlashLoanProviders {
    AAVEV1,
    BALANCER,
    EULER,
    MAKERDAO,
    UNISWAPV2
}

library FlashLoanProvider {
    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider
     * @param flp The flash loan provider to take the loan from
     * @param tokens The addresses of the tokens to borrow
     * @param amounts The amounts of the tokens to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, address[] memory tokens, uint256[] memory amounts) internal {
        if (flp == FlashLoanProviders.BALANCER) {
            BalancerFlashLoan.takeFlashLoan(tokens, amounts);
        } else {
            revert("FlashLoanProvider: Provider doesn't support multiple token flash loans");
        }
    }

    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider
     * @param flp The flashloan provider to take the loan from
     * @param token The address of the token to borrow
     * @param amount The amount of the token to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, address token, uint256 amount) internal {
        if (flp == FlashLoanProviders.AAVEV1) {
            AAVEV1FlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.BALANCER) {
            BalancerFlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.EULER) {
            EulerFlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.MAKERDAO) {
            MakerDAOFlashLoan.takeFlashLoan(token, amount);
        } else {
            revert("FlashLoanProvider: Provider doesn't support single token flash loans");
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
            BalancerFlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.EULER) {
            EulerFlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.MAKERDAO) {
            MakerDAOFlashLoan.payFlashLoan(msg.data);
        } else {
            revert("FlashLoanProvider: Flash loan provider not supported");
        }
    }

    /**
     * @dev Gets the bytes4 function selector for the intended flash loan callback
     * @param flp The flashloan provider to get the callback selector of
     */
    function callbackFunctionSelector(FlashLoanProviders flp) internal returns (bytes4) {
        if (flp == FlashLoanProviders.AAVEV1) {
            return AAVEV1FlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.BALANCER) {
            return BalancerFlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.EULER) {
            return EulerFlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.MAKERDAO) {
            return MakerDAOFlashLoan.CALLBACK_SELECTOR;
        }
    }

    /**
     * @dev Gets the bytes32 return data for the intended flash loan callback
     * @param flp The flashloan provider to get the return data of
     */
    function returnData(FlashLoanProviders flp) internal returns (bytes32) {
        if (flp == FlashLoanProviders.MAKERDAO) {
            return MakerDAOFlashLoan.RETURN_DATA;
        }
    }
}
