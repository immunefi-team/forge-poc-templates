## Vulnerability Type
This template is for adding powerful, granular, and fully customizable logging capabilities to your PoCs.

The template provides a foundry/hardhat-like console logging interface with manual control over what types of messages can be logged to avoid mass commenting/uncommenting code and a simple switch to turn all logging from this template on or off.

For even further control over the logging behavior all functions can be overridden.

## Usage

Log messages in a foundry/hardhat-style, but instead of calling a library (`console.log(...)`), all functions are internal (`_log(...)`):

```solidity
// Log a string
_log("Funds deposited");

// Log a string with a uint256 variable "_deposited"
_log("Funds deposited: %s", _deposited);

// Log an int256 variable "_negativeValue"
_logInt(_negativeValue);
```

Turn off logging:
```solidity
// Disable logging
_setLogType(LogType.NONE);
```

Log everything:
```solidity
// Enable logging and log all messages from all phases of the attack vector
_setLogType(LogType.ALL);
```

Log messages from a specific phase of the attack vector:
```solidity
// Only log messages from the Complete Attack phase
_setLogType(LogType.COMPLETE_ATTACK);
```

A `LogType` for every main phase of an attack vector is supported. Additionally, up to 10 steps can be defined to group and control logs related to every step of an attack vector:

| Phase | Code |
| ---------- | ------------------------------------------------------- |
| `INITIALIZE_ATTACK` | `_setLogType(LogType.INITIALIZE_ATTACK);` |
| `EXECUTE_ATTACK` | `_setLogType(LogType.EXECUTE_ATTACK);` |
| `COMPLETE_ATTACK` | `_setLogType(LogType.COMPLETE_ATTACK);` |
| `STEP_1` | `_setLogType(LogType.STEP_1);` |
| `STEP_2` | `_setLogType(LogType.STEP_2);` |
| `STEP_3` | `_setLogType(LogType.STEP_3);` |
| `STEP_4` | `_setLogType(LogType.STEP_4);` |
| `STEP_5` | `_setLogType(LogType.STEP_5);` |
| `STEP_6` | `_setLogType(LogType.STEP_6);` |
| `STEP_7` | `_setLogType(LogType.STEP_7);` |
| `STEP_8` | `_setLogType(LogType.STEP_8);` |
| `STEP_9` | `_setLogType(LogType.STEP_9);` |
| `STEP_10` | `_setLogType(LogType.STEP_10);` |


Automatically control the lifecicle of a phase by adding a modifier to any function:
```solidity
/**
  * @dev Adding the modifier `step_1` to the "depositFunds()" function
  * defines the start and end of the STEP_1 Phase and allows turning
  * on and off all logging within this phase.
  */
function depositFunds() public step_1 {

    // Approve Market to spend DSU tokens
    DSU.approve(address(market), UINT256_MAX);

    // Log the balance before depositing
    uint256 balanceBefore = DSU.balanceOf(address(this));
    _log("Balance before deposit: %s", balanceBefore);

    // Deposit in market DSU balance
    market.update(
        address(this), // account
        0, // newMaker
        0, // newLong
        0, // newShort
        int256(1000000 * 1e6), // collateral
        false); // protect

    // Log balance after deposit
    uint256 balanceAfter = DSU.balanceOf(address(this));
    _log("Balance before deposit: %s", balanceAfter);
}
```

Manually control the lifecicle of a phase:
```solidity
// Manually start STEP_1 phase
_setPhase(LogPhase.STEP_1);

// Manually start STEP_2 phase
_setPhase(LogPhase.STEP_2);

// Manually end all phases (set the default phase)
_setPhase(LogPhase.DEFAULT);

```

A `LogPhase` for every main phase of an attack vector is supported. Additionally, up to 10 steps can be defined to group and control logs related to every step of an attack vector:

| Phase | Code |
| ---------- | ------------------------------------------------------- |
| `INITIALIZE_ATTACK` | `_setPhase(LogPhase.INITIALIZE_ATTACK);` |
| `EXECUTE_ATTACK` | `_setPhase(LogPhase.EXECUTE_ATTACK);` |
| `COMPLETE_ATTACK` | `_setPhase(LogPhase.COMPLETE_ATTACK);` |
| `STEP_1` | `_setPhase(LogPhase.STEP_1);` |
| `STEP_2` | `_setPhase(LogPhase.STEP_2);` |
| `STEP_3` | `_setPhase(LogPhase.STEP_3);` |
| `STEP_4` | `_setPhase(LogPhase.STEP_4);` |
| `STEP_5` | `_setPhase(LogPhase.STEP_5);` |
| `STEP_6` | `_setPhase(LogPhase.STEP_6);` |
| `STEP_7` | `_setPhase(LogPhase.STEP_7);` |
| `STEP_8` | `_setPhase(LogPhase.STEP_8);` |
| `STEP_9` | `_setPhase(LogPhase.STEP_9);` |
| `STEP_10` | `_setPhase(LogPhase.STEP_10);` |
