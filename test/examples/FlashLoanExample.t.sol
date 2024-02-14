pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../../src/flashloan/examples/FlashLoanExample.sol";
import "../../src/flashloan/examples/MultiProviderFlashLoanExample.sol";

contract FlashLoanExampleTest is Test {
    uint256 mainnetFork;

    FlashLoanExample public flashLoanExample;
    MultiProviderFlashLoanExample public multiProviderFlashLoanExample;

    function setUp() public {
        mainnetFork = vm.createFork("eth");
        vm.selectFork(mainnetFork);

        flashLoanExample = new FlashLoanExample();
        multiProviderFlashLoanExample = new MultiProviderFlashLoanExample();
    }

    /**
     * @dev Flash loans only work from block 19168280 or earlier.
     */
    // function testAAVEV1FlashLoan() public {
    //     flashLoanExample.initiateAttack(FlashLoanProviders.AAVEV1);
    // }

    function testAAVEV2FlashLoan() public {
        flashLoanExample.initiateAttack(FlashLoanProviders.AAVEV2);
    }

    function testAAVEV3FlashLoan() public {
        flashLoanExample.initiateAttack(FlashLoanProviders.AAVEV3);
    }

    function testBalancerFlashLoan() public {
        flashLoanExample.initiateAttack(FlashLoanProviders.BALANCER);
    }

    /**
     * @dev Flash loans only work from block 16818068 or earlier.
     */
    // function testEulerFlashLoan() public {
    //     flashLoanExample.initiateAttack(FlashLoanProviders.EULER);
    // }

    function testMakerDAOFlashLoan() public {
        flashLoanExample.initiateAttack(FlashLoanProviders.MAKERDAO);
    }

    function testUniswapV2FlashLoan() public {
        flashLoanExample.initiateAttack(FlashLoanProviders.UNISWAPV2);
    }

    function testUniswapV3FlashLoan() public {
        flashLoanExample.initiateAttack(FlashLoanProviders.UNISWAPV3);
    }

    function testMultiProviderFlashLoan() public {
        multiProviderFlashLoanExample.initiateAttack();
    }
}
