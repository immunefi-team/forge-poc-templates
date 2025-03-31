pragma solidity >=0.4.22 <0.9.0;

/// @dev The following code was pulled from forge-std console2.sol and modified
/// to include additional functionality for granular logging
abstract contract Log {
    /**
     * @dev Function to log a dashed line for better log readability
     */
    function _dash() internal view virtual {
        _log("---------------------------------------------------------------------------");
    }

    // Enum defining different phases for logging
    enum LogPhase {
        // Default phase
        DEFAULT,
        // Log messages from the "Initiate Attack" phase
        INITIALIZE_ATTACK,
        // Log messages from the "Execute Attack" phase
        EXECUTE_ATTACK,
        // Log messages from the "Complete Attack" phase
        COMPLETE_ATTACK,
        // Log messages from a custom phase of the attack vector
        STEP_1,
        STEP_2,
        STEP_3,
        STEP_4,
        STEP_5,
        STEP_6,
        STEP_7,
        STEP_8,
        STEP_9,
        STEP_10
    }

    // Enum defining different types of logs
    enum LogType {
        // Log everything
        ALL,
        // Log messages from the "Initiate Attack" phase
        INITIALIZE_ATTACK,
        // Log messages from the "Execute Attack" phase
        EXECUTE_ATTACK,
        // Log messages from the "Complete Attack" phase
        COMPLETE_ATTACK,
        // Log messages from a custom phase of the attack vector
        STEP_1,
        STEP_2,
        STEP_3,
        STEP_4,
        STEP_5,
        STEP_6,
        STEP_7,
        STEP_8,
        STEP_9,
        STEP_10,
        // Log nothing
        NONE
    }

    // Current log type and phase
    LogType logType;
    LogPhase currentPhase;

    /**
     * @dev Function to set the current log phase
     * @param _currentPhase current log phase
     */
    function _setPhase(LogPhase _currentPhase) internal virtual {
        currentPhase = _currentPhase;
    }

    /**
     * @dev Function to set the current log type
     * @param _logType current log type
     */
    function _setLogType(LogType _logType) internal virtual {
        logType = _logType;
    }

    /**
     * @dev Modifier to check if logging is allowed based on the current log type and phase
     */
    modifier _canLog() virtual {
        // If the log type is NONE, then logging is disabled
        if (logType == LogType.NONE) return;

        // Check if either the log type is ALL or the log type matches the current phase
        if ((logType == LogType.ALL) || (uint256(logType) == uint256(currentPhase))) {
            _;
        }
    }

    /**
     * @dev Modifiers for each specific phase. Reset the phase to DEFAULT after the function is executed.
     */
    modifier step_1() virtual {
        _setPhase(LogPhase.STEP_1);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_2() virtual {
        _setPhase(LogPhase.STEP_2);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_3() virtual {
        _setPhase(LogPhase.STEP_3);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_4() virtual {
        _setPhase(LogPhase.STEP_4);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_5() virtual {
        _setPhase(LogPhase.STEP_5);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_6() virtual {
        _setPhase(LogPhase.STEP_6);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_7() virtual {
        _setPhase(LogPhase.STEP_7);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_8() virtual {
        _setPhase(LogPhase.STEP_8);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_9() virtual {
        _setPhase(LogPhase.STEP_9);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier step_10() virtual {
        _setPhase(LogPhase.STEP_10);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier initialize_attack() virtual {
        _setPhase(LogPhase.INITIALIZE_ATTACK);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier execute_attack() virtual {
        _setPhase(LogPhase.EXECUTE_ATTACK);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    modifier complete_attack() virtual {
        _setPhase(LogPhase.COMPLETE_ATTACK);
        _;
        _setPhase(LogPhase.DEFAULT);
    }

    address constant CONSOLE_ADDRESS = address(0x000000000000000000636F6e736F6c652e6c6f67);

    function _sendLogPayloadVirtual(bytes memory payload) internal view virtual _canLog {
        uint256 payloadLength = payload.length;
        address consoleAddress = CONSOLE_ADDRESS;
        /// @solidity memory-safe-assembly
        assembly {
            let payloadStart := add(payload, 32)
            let r := staticcall(gas(), consoleAddress, payloadStart, payloadLength, 0, 0)
        }
    }

    function _log() internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log()"));
    }

    function _logInt(int256 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(int256)", p0));
    }

    function _logUint(uint256 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256)", p0));
    }

    function _logString(string memory p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string)", p0));
    }

    function _logBool(bool p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool)", p0));
    }

    function _logAddress(address p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address)", p0));
    }

    function _logBytes(bytes memory p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes)", p0));
    }

    function _logBytes1(bytes1 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes1)", p0));
    }

    function _logBytes2(bytes2 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes2)", p0));
    }

    function _logBytes3(bytes3 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes3)", p0));
    }

    function _logBytes4(bytes4 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes4)", p0));
    }

    function _logBytes5(bytes5 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes5)", p0));
    }

    function _logBytes6(bytes6 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes6)", p0));
    }

    function _logBytes7(bytes7 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes7)", p0));
    }

    function _logBytes8(bytes8 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes8)", p0));
    }

    function _logBytes9(bytes9 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes9)", p0));
    }

    function _logBytes10(bytes10 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes10)", p0));
    }

    function _logBytes11(bytes11 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes11)", p0));
    }

    function _logBytes12(bytes12 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes12)", p0));
    }

    function _logBytes13(bytes13 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes13)", p0));
    }

    function _logBytes14(bytes14 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes14)", p0));
    }

    function _logBytes15(bytes15 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes15)", p0));
    }

    function _logBytes16(bytes16 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes16)", p0));
    }

    function _logBytes17(bytes17 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes17)", p0));
    }

    function _logBytes18(bytes18 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes18)", p0));
    }

    function _logBytes19(bytes19 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes19)", p0));
    }

    function _logBytes20(bytes20 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes20)", p0));
    }

    function _logBytes21(bytes21 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes21)", p0));
    }

    function _logBytes22(bytes22 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes22)", p0));
    }

    function _logBytes23(bytes23 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes23)", p0));
    }

    function _logBytes24(bytes24 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes24)", p0));
    }

    function _logBytes25(bytes25 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes25)", p0));
    }

    function _logBytes26(bytes26 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes26)", p0));
    }

    function _logBytes27(bytes27 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes27)", p0));
    }

    function _logBytes28(bytes28 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes28)", p0));
    }

    function _logBytes29(bytes29 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes29)", p0));
    }

    function _logBytes30(bytes30 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes30)", p0));
    }

    function _logBytes31(bytes31 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes31)", p0));
    }

    function _logBytes32(bytes32 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bytes32)", p0));
    }

    function _log(uint256 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256)", p0));
    }

    function _log(int256 p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(int256)", p0));
    }

    function _log(string memory p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string)", p0));
    }

    function _log(bool p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool)", p0));
    }

    function _log(address p0) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address)", p0));
    }

    function _log(uint256 p0, uint256 p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256)", p0, p1));
    }

    function _log(uint256 p0, string memory p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string)", p0, p1));
    }

    function _log(uint256 p0, bool p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool)", p0, p1));
    }

    function _log(uint256 p0, address p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address)", p0, p1));
    }

    function _log(string memory p0, uint256 p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256)", p0, p1));
    }

    function _log(string memory p0, int256 p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,int256)", p0, p1));
    }

    function _log(string memory p0, string memory p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string)", p0, p1));
    }

    function _log(string memory p0, bool p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool)", p0, p1));
    }

    function _log(string memory p0, address p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address)", p0, p1));
    }

    function _log(bool p0, uint256 p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256)", p0, p1));
    }

    function _log(bool p0, string memory p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string)", p0, p1));
    }

    function _log(bool p0, bool p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool)", p0, p1));
    }

    function _log(bool p0, address p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address)", p0, p1));
    }

    function _log(address p0, uint256 p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256)", p0, p1));
    }

    function _log(address p0, string memory p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string)", p0, p1));
    }

    function _log(address p0, bool p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool)", p0, p1));
    }

    function _log(address p0, address p1) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address)", p0, p1));
    }

    function _log(uint256 p0, uint256 p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,uint256)", p0, p1, p2));
    }

    function _log(uint256 p0, uint256 p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,string)", p0, p1, p2));
    }

    function _log(uint256 p0, uint256 p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,bool)", p0, p1, p2));
    }

    function _log(uint256 p0, uint256 p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,address)", p0, p1, p2));
    }

    function _log(uint256 p0, string memory p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,uint256)", p0, p1, p2));
    }

    function _log(uint256 p0, string memory p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,string)", p0, p1, p2));
    }

    function _log(uint256 p0, string memory p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,bool)", p0, p1, p2));
    }

    function _log(uint256 p0, string memory p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,address)", p0, p1, p2));
    }

    function _log(uint256 p0, bool p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,uint256)", p0, p1, p2));
    }

    function _log(uint256 p0, bool p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,string)", p0, p1, p2));
    }

    function _log(uint256 p0, bool p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,bool)", p0, p1, p2));
    }

    function _log(uint256 p0, bool p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,address)", p0, p1, p2));
    }

    function _log(uint256 p0, address p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,uint256)", p0, p1, p2));
    }

    function _log(uint256 p0, address p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,string)", p0, p1, p2));
    }

    function _log(uint256 p0, address p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,bool)", p0, p1, p2));
    }

    function _log(uint256 p0, address p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,address)", p0, p1, p2));
    }

    function _log(string memory p0, uint256 p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,uint256)", p0, p1, p2));
    }

    function _log(string memory p0, uint256 p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,string)", p0, p1, p2));
    }

    function _log(string memory p0, uint256 p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,bool)", p0, p1, p2));
    }

    function _log(string memory p0, uint256 p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,address)", p0, p1, p2));
    }

    function _log(string memory p0, string memory p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,uint256)", p0, p1, p2));
    }

    function _log(string memory p0, string memory p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,string)", p0, p1, p2));
    }

    function _log(string memory p0, string memory p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,bool)", p0, p1, p2));
    }

    function _log(string memory p0, string memory p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,address)", p0, p1, p2));
    }

    function _log(string memory p0, bool p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,uint256)", p0, p1, p2));
    }

    function _log(string memory p0, bool p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,string)", p0, p1, p2));
    }

    function _log(string memory p0, bool p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,bool)", p0, p1, p2));
    }

    function _log(string memory p0, bool p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,address)", p0, p1, p2));
    }

    function _log(string memory p0, address p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,uint256)", p0, p1, p2));
    }

    function _log(string memory p0, address p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,string)", p0, p1, p2));
    }

    function _log(string memory p0, address p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,bool)", p0, p1, p2));
    }

    function _log(string memory p0, address p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,address)", p0, p1, p2));
    }

    function _log(bool p0, uint256 p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,uint256)", p0, p1, p2));
    }

    function _log(bool p0, uint256 p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,string)", p0, p1, p2));
    }

    function _log(bool p0, uint256 p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,bool)", p0, p1, p2));
    }

    function _log(bool p0, uint256 p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,address)", p0, p1, p2));
    }

    function _log(bool p0, string memory p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,uint256)", p0, p1, p2));
    }

    function _log(bool p0, string memory p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,string)", p0, p1, p2));
    }

    function _log(bool p0, string memory p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,bool)", p0, p1, p2));
    }

    function _log(bool p0, string memory p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,address)", p0, p1, p2));
    }

    function _log(bool p0, bool p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,uint256)", p0, p1, p2));
    }

    function _log(bool p0, bool p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,string)", p0, p1, p2));
    }

    function _log(bool p0, bool p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,bool)", p0, p1, p2));
    }

    function _log(bool p0, bool p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,address)", p0, p1, p2));
    }

    function _log(bool p0, address p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,uint256)", p0, p1, p2));
    }

    function _log(bool p0, address p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,string)", p0, p1, p2));
    }

    function _log(bool p0, address p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,bool)", p0, p1, p2));
    }

    function _log(bool p0, address p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,address)", p0, p1, p2));
    }

    function _log(address p0, uint256 p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,uint256)", p0, p1, p2));
    }

    function _log(address p0, uint256 p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,string)", p0, p1, p2));
    }

    function _log(address p0, uint256 p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,bool)", p0, p1, p2));
    }

    function _log(address p0, uint256 p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,address)", p0, p1, p2));
    }

    function _log(address p0, string memory p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,uint256)", p0, p1, p2));
    }

    function _log(address p0, string memory p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,string)", p0, p1, p2));
    }

    function _log(address p0, string memory p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,bool)", p0, p1, p2));
    }

    function _log(address p0, string memory p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,address)", p0, p1, p2));
    }

    function _log(address p0, bool p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,uint256)", p0, p1, p2));
    }

    function _log(address p0, bool p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,string)", p0, p1, p2));
    }

    function _log(address p0, bool p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,bool)", p0, p1, p2));
    }

    function _log(address p0, bool p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,address)", p0, p1, p2));
    }

    function _log(address p0, address p1, uint256 p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,uint256)", p0, p1, p2));
    }

    function _log(address p0, address p1, string memory p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,string)", p0, p1, p2));
    }

    function _log(address p0, address p1, bool p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,bool)", p0, p1, p2));
    }

    function _log(address p0, address p1, address p2) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,address)", p0, p1, p2));
    }

    function _log(uint256 p0, uint256 p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,uint256,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,uint256,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,string,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,string,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,string,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,string,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,bool,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,bool,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,bool,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,address,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,address,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,address,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, uint256 p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,uint256,address,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,uint256,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,uint256,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,string,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,string,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,string,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,string,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,bool,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,bool,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,bool,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,address,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,address,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,address,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, string memory p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,string,address,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,uint256,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,uint256,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,string,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,string,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,string,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,string,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,bool,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,bool,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,bool,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,address,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,address,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,address,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, bool p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,bool,address,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,uint256,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,uint256,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,string,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,string,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,string,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,string,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,bool,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,bool,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,bool,address)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,address,uint256)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,address,string)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,address,bool)", p0, p1, p2, p3));
    }

    function _log(uint256 p0, address p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(uint256,address,address,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,uint256,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,uint256,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,string,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,string,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,string,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,string,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,bool,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,bool,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,bool,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,address,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,address,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,address,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, uint256 p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,uint256,address,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,uint256,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,uint256,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,string,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,string,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,string,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,string,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,bool,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,bool,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,bool,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,address,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,address,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,address,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, string memory p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,string,address,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,uint256,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,uint256,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,string,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,string,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,string,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,string,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,bool,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,bool,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,bool,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,address,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,address,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,address,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, bool p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,bool,address,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,uint256,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,uint256,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,string,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,string,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,string,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,string,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,bool,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,bool,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,bool,address)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,address,uint256)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,address,string)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,address,bool)", p0, p1, p2, p3));
    }

    function _log(string memory p0, address p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(string,address,address,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,uint256,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,uint256,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,string,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,string,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,string,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,string,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,bool,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,bool,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,bool,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,address,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,address,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,address,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, uint256 p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,uint256,address,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,uint256,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,uint256,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,string,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,string,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,string,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,string,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,bool,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,bool,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,bool,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,address,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,address,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,address,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, string memory p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,string,address,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,uint256,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,uint256,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,string,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,string,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,string,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,string,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,bool,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,bool,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,bool,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,address,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,address,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,address,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, bool p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,bool,address,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,uint256,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,uint256,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,string,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,string,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,string,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,string,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,bool,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,bool,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,bool,address)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,address,uint256)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,address,string)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,address,bool)", p0, p1, p2, p3));
    }

    function _log(bool p0, address p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(bool,address,address,address)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,uint256,string)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,uint256,address)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,string,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,string,string)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,string,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,string,address)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,bool,string)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,bool,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,bool,address)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,address,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,address,string)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,address,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, uint256 p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,uint256,address,address)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,uint256,string)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,uint256,address)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,string,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,string,string)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,string,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,string,address)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,bool,string)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,bool,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,bool,address)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,address,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,address,string)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,address,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, string memory p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,string,address,address)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,uint256,string)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,uint256,address)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,string,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,string,string)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,string,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,string,address)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,bool,string)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,bool,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,bool,address)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,address,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,address,string)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,address,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, bool p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,bool,address,address)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, uint256 p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,uint256,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, uint256 p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,uint256,string)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, uint256 p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,uint256,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, uint256 p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,uint256,address)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, string memory p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,string,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, string memory p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,string,string)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, string memory p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,string,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, string memory p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,string,address)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, bool p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,bool,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, bool p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,bool,string)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, bool p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,bool,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, bool p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,bool,address)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, address p2, uint256 p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,address,uint256)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, address p2, string memory p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,address,string)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, address p2, bool p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,address,bool)", p0, p1, p2, p3));
    }

    function _log(address p0, address p1, address p2, address p3) internal view virtual {
        _sendLogPayloadVirtual(abi.encodeWithSignature("log(address,address,address,address)", p0, p1, p2, p3));
    }
}
