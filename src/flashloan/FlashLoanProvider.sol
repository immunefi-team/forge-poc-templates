pragma solidity ^0.8.0;

import {AAVEV1FlashLoan} from "./lib/AAVEV1FlashLoan.sol";
import {AAVEV2FlashLoan} from "./lib/AAVEV2FlashLoan.sol";
import {AAVEV3FlashLoan} from "./lib/AAVEV3FlashLoan.sol";
import {EulerFlashLoan} from "./lib/EulerFlashLoan.sol";
import {BalancerFlashLoan} from "./lib/BalancerFlashLoan.sol";
import {MakerDAOFlashLoan} from "./lib/MakerDAOFlashLoan.sol";
import {UniswapV2FlashLoan} from "./lib/UniswapV2FlashLoan.sol";
import {UniswapV3FlashLoan} from "./lib/UniswapV3FlashLoan.sol";

enum FlashLoanProviders {
    NONE,
    AAVEV1,
    AAVEV2,
    AAVEV3,
    BALANCER,
    EULER,
    MAKERDAO,
    UNISWAPV2,
    UNISWAPV3
}

library FlashLoanProvider {
    /**
     * @dev Returns the name of the specified flash loan provider
     */
    function name(FlashLoanProviders flp) internal pure returns (string memory) {
        if (flp == FlashLoanProviders.AAVEV1) {
            return "AAVEV1";
        } else if (flp == FlashLoanProviders.AAVEV2) {
            return "AAVEV2";
        } else if (flp == FlashLoanProviders.AAVEV3) {
            return "AAVEV3";
        } else if (flp == FlashLoanProviders.BALANCER) {
            return "Balancer";
        } else if (flp == FlashLoanProviders.EULER) {
            return "Euler";
        } else if (flp == FlashLoanProviders.MAKERDAO) {
            return "MakerDAO";
        } else if (flp == FlashLoanProviders.UNISWAPV2) {
            return "UniswapV2";
        } else if (flp == FlashLoanProviders.UNISWAPV3) {
            return "UniswapV3";
        } else {
            return "None";
        }
    }

    /**
     * @dev Allows a user to take a flash loan from a specified FlashloanProvider
     * @param flp The flash loan provider to take the loan from
     * @param tokens The addresses of the tokens to borrow
     * @param amounts The amounts of the tokens to borrow
     */
    function takeFlashLoan(FlashLoanProviders flp, address[] memory tokens, uint256[] memory amounts) internal {
        if (flp == FlashLoanProviders.BALANCER) {
            BalancerFlashLoan.takeFlashLoan(tokens, amounts);
        } else if (flp == FlashLoanProviders.UNISWAPV2) {
            UniswapV2FlashLoan.takeFlashLoan(tokens, amounts);
        } else if (flp == FlashLoanProviders.AAVEV2) {
            AAVEV2FlashLoan.takeFlashLoan(tokens, amounts);
        } else if (flp == FlashLoanProviders.AAVEV3) {
            AAVEV3FlashLoan.takeFlashLoan(tokens, amounts);
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
        } else if (flp == FlashLoanProviders.AAVEV2) {
            AAVEV2FlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.AAVEV3) {
            AAVEV3FlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.BALANCER) {
            BalancerFlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.EULER) {
            EulerFlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.MAKERDAO) {
            MakerDAOFlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.UNISWAPV2) {
            UniswapV2FlashLoan.takeFlashLoan(token, amount);
        } else if (flp == FlashLoanProviders.UNISWAPV3) {
            UniswapV3FlashLoan.takeFlashLoan(token, amount);
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
        } else if (flp == FlashLoanProviders.AAVEV2) {
            AAVEV2FlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.AAVEV3) {
            AAVEV3FlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.BALANCER) {
            BalancerFlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.EULER) {
            EulerFlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.MAKERDAO) {
            MakerDAOFlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.UNISWAPV2) {
            UniswapV2FlashLoan.payFlashLoan(msg.data);
        } else if (flp == FlashLoanProviders.UNISWAPV3) {
            UniswapV3FlashLoan.payFlashLoan(msg.data);
        } else {
            revert("FlashLoanProvider: Flash loan provider not supported");
        }
    }

    /**
     * @dev Gets the bytes4 function selector for the intended flash loan callback
     * @param flp The flashloan provider to get the callback selector of
     */
    function callbackFunctionSelector(FlashLoanProviders flp) internal pure returns (bytes4) {
        if (flp == FlashLoanProviders.AAVEV1) {
            return AAVEV1FlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.AAVEV2) {
            return AAVEV2FlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.AAVEV3) {
            return AAVEV3FlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.BALANCER) {
            return BalancerFlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.EULER) {
            return EulerFlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.MAKERDAO) {
            return MakerDAOFlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.UNISWAPV2) {
            return UniswapV2FlashLoan.CALLBACK_SELECTOR;
        } else if (flp == FlashLoanProviders.UNISWAPV3) {
            return UniswapV3FlashLoan.CALLBACK_SELECTOR;
        }
    }

    /**
     * @dev Gets the bytes32 return data for the intended flash loan callback
     * @param flp The flashloan provider to get the return data of
     */
    function returnData(FlashLoanProviders flp) internal pure returns (bytes memory) {
        if (flp == FlashLoanProviders.MAKERDAO) {
            return MakerDAOFlashLoan.RETURN_DATA;
        } else if (flp == FlashLoanProviders.AAVEV2) {
            return AAVEV2FlashLoan.RETURN_DATA;
        } else if (flp == FlashLoanProviders.AAVEV3) {
            return AAVEV3FlashLoan.RETURN_DATA;
        }
    }
}
