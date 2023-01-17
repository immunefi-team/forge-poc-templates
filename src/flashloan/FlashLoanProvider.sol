pragma solidity ^0.8.0;

import {AAVEFlashloan} from "./lib/AAVEFlashloan.sol";

enum FlashloanProviders {
    AAVE,
    BALANCER,
    EULER
}

library FlashloanProvider {
    function takeFlashLoan(FlashloanProviders flp, address token, uint256 amount) internal {
        if (flp == FlashloanProviders.AAVE) {
            AAVEFlashloan.takeFlashLoan(token, amount);
        } else if (flp == FlashloanProviders.BALANCER) {} else if (flp == FlashloanProviders.BALANCER) {}
    }

    function payFlashLoan(FlashloanProviders flp) internal {
        if (flp == FlashloanProviders.AAVE) {
            AAVEFlashloan.payFlashLoan(msg.data);
        } else if (flp == FlashloanProviders.BALANCER) {} else if (flp == FlashloanProviders.BALANCER) {}
    }
}
