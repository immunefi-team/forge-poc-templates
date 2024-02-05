pragma solidity ^0.8.0;

import "forge-std/console.sol";

import "../lib/MockPyth.sol";

contract MockOracleExample {
    // TODO: provide list of all referencable price feeds
    bytes32 pid = 0x2f95862b045670cd22bee3114c39763a4a08beeb663b145d283c31d7d1101c4f; // BNB/USD

    function initiateAttack() external {
        MockPyth.mockOracleData(pid, 1);

        _executeAttack();
    }

    function _executeAttack() internal {
        PythUpgradable pyth = PythUpgradable(0x4305FB66699C3B2702D4d05CF36551390A4c69C6);
        PythUpgradable.Price memory p = pyth.getPriceUnsafe(pid);
        console.logInt(p.price);
        _completeAttack();
    }

    function _completeAttack() internal {}
}
