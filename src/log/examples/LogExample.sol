pragma solidity ^0.8.0;

import "../Log.sol";

contract LogExample is Log {
    function initializeAttack() public initialize_attack {
        // Turn off all logs except from those inside the `initializeAttack()` function
        //_setLogType(LogType.INITIALIZE_ATTACK);

        // Turn off all logs except from those inside the `_executeAttack()` function
        //_setLogType(LogType.EXECUTE_ATTACK);

        // Turn off all logs except from those inside the `_completeAttack()` function
        //_setLogType(LogType.COMPLETE_ATTACK);

        // Turn off all logs
        _setLogType(LogType.NONE);

        _log("\n>>> Initialize attack");

        _executeAttack();
    }

    function _executeAttack() internal execute_attack {
        _log("\n>>> Execute attack");

        _completeAttack();
    }

    function _completeAttack() internal complete_attack {
        _log("\n>>> Complete attack");
    }
}
