pragma solidity ^0.8.0;

import "../../tokens/Tokens.sol";
import "forge-std/Vm.sol";

library MockBand {
    address constant HEVM_ADDRESS = address(bytes20(uint160(uint256(keccak256("hevm cheat code")))));
    Vm constant vm = Vm(HEVM_ADDRESS);

    struct Context {
        IStdReference ref;
    }

    function mockOracleData(string memory baseToken, string memory quoteToken, uint256 price) internal {
        Context memory context = context();

        IStdReference.ReferenceData memory data = context.ref.getReferenceData(baseToken, quoteToken);

        vm.mockCall(
            address(context.ref),
            abi.encodeCall(IStdReference.getReferenceData, (baseToken, quoteToken)),
            abi.encode(price, data.lastUpdatedBase, data.lastUpdatedQuote)
        );
    }

    function context() internal view returns (Context memory) {
        IStdReference ref;

        // https://docs.bandchain.org/develop/supported-blockchains/#mainnets
        if (block.chainid == 1) {
            // Ethereum Mainnet
            ref = IStdReference(0xDA7a001b254CD22e46d3eAB04d937489c93174C3);
        } else if (block.chainid == 10) {
            // Optimism
            ref = IStdReference(0xDA7a001b254CD22e46d3eAB04d937489c93174C3);
        } else if (block.chainid == 56) {
            // BSC
            ref = IStdReference(0xDA7a001b254CD22e46d3eAB04d937489c93174C3);
        } else if (block.chainid == 43114) {
            // Avalanche
            ref = IStdReference(0x75B01902D9297fD381bcF3B155a8cEAC78F5A35E);
        } else if (block.chainid == 42220) {
            // Celo
            ref = IStdReference(0xDA7a001b254CD22e46d3eAB04d937489c93174C3);
        } else if (block.chainid == 32659) {
            // Fusion
            ref = IStdReference(0xDA7a001b254CD22e46d3eAB04d937489c93174C3);
        } else if (block.chainid == 2020) {
            // Horizen (EON)
            ref = IStdReference(0xA55d9ef16Af921b70Fed1421C1D298Ca5A3a18F1);
        } else if (block.chainid == 82) {
            // Meter
            ref = IStdReference(0x861C20f77f194EEa4f86e0d39069D789265A3A82);
        } else if (block.chainid == 1285) {
            // Moonriver
            ref = IStdReference(0x75B01902D9297fD381bcF3B155a8cEAC78F5A35E);
        } else {
            console.log(block.chainid);
            revert("MockBandOracle: Chain not supported");
        }

        return Context(ref);
    }
}

interface IStdReference {
    /// A structure returned whenever someone requests for standard reference data.
    struct ReferenceData {
        uint256 rate; // base/quote exchange rate, multiplied by 1e18.
        uint256 lastUpdatedBase; // UNIX epoch of the last time when base price gets updated.
        uint256 lastUpdatedQuote; // UNIX epoch of the last time when quote price gets updated.
    }

    /// Returns the price data for the given base/quote pair. Revert if not available.
    function getReferenceData(string memory _base, string memory _quote) external view returns (ReferenceData memory);

    /// Similar to getReferenceData, but with multiple base/quote pairs at once.
    function getReferenceDataBulk(string[] memory _bases, string[] memory _quotes)
        external
        view
        returns (ReferenceData[] memory);
}

//TODO: Integrate this : https://github.com/bandprotocol/IPFS/blob/06c2693da8976b5a3caafb8a30470e791f75a781/testnet/staging/crypto.rs#L44
library BaseQuoteTokens {
    enum Base {
        AAVE,
        ABYSS,
        ADA,
        AKRO,
        ALCX,
        ALGO,
        ALPHA,
        AMPL,
        ANC,
        ANT,
        ARPA,
        AST,
        ATOM,
        AUTO,
        AVAX,
        AXS,
        BAL,
        BAND,
        BAT,
        BCH,
        BEL,
        BETA,
        BLZ,
        BNB,
        BNT,
        BOBA,
        BSV,
        BTC,
        BTG,
        BTM,
        BTS,
        BTT,
        BUSD,
        BZRX,
        C98,
        CAKE,
        CELO,
        CKB,
        COMP,
        CREAM,
        CRO,
        CRV,
        CUSD,
        CVC,
        DAI,
        DASH,
        DCR,
        DGB,
        DIA,
        DOGE,
        DOT,
        DPI,
        EGLD,
        ELF,
        ENJ,
        EOS,
        ETC,
        ETH,
        EURS,
        EWT,
        FET,
        FIL,
        FOR,
        FRAX,
        FTM,
        FTT,
        GNO,
        GRT,
        HBAR,
        HEGIC,
        HT,
        ICX,
        INJ,
        IOST,
        IOTX,
        JOE,
        JST,
        KAI,
        KAVA,
        KDA,
        KEY,
        KMD,
        KP3R,
        KSM,
        LEO,
        LINA,
        LINK,
        LOOM,
        LRC,
        LSK,
        LTC,
        LUNA,
        MANA,
        MATIC,
        MIM,
        MIOTA,
        MIR,
        MKR,
        MLN,
        MOVR,
        MTA,
        MTL,
        MVL,
        NEAR,
        NEO,
        NMR,
        OCEAN,
        OGN,
        OKB,
        OMG,
        ONE,
        ONT,
        OSMO,
        PAXG,
        PERP,
        PICKLE,
        PLR,
        PNK,
        PNT,
        POLY,
        POWR,
        QKC,
        QNT,
        QTUM,
        REN,
        REP,
        REQ,
        RLC,
        ROSE,
        RSR,
        RSV,
        RUNE,
        RVN,
        SAND,
        SC,
        SCRT,
        SFI,
        SHIB,
        SNT,
        SNX,
        SOL,
        SPELL,
        SRM,
        STMX,
        STORJ,
        STRK,
        STX,
        SUSD,
        SUSHI,
        SXP,
        THETA,
        TOMO,
        TRB,
        TRX,
        TUSD,
        TWT,
        UBT,
        UMA,
        UNI,
        UPP,
        USDC,
        USDP,
        USDT,
        UST,
        VET,
        VIDT,
        WAN,
        WAVES,
        WBTC,
        WNXM,
        WRX,
        XEM,
        XLM,
        XMR,
        XRP,
        XTZ,
        XVS,
        YAM,
        YAMV2,
        YFI,
        YFII,
        ZEC,
        ZIL,
        ZRX
    }
    enum Quote {
        USD,
        ETH,
        BTC
    }
}
