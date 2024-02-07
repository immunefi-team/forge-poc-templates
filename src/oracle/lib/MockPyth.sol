pragma solidity ^0.8.0;

import "forge-std/Vm.sol";

/**
 * MockPyth is a library used to facilitate mocking interactions with Pyth Oracles.
 * This includes functions to mock oracle data for testing and to retrieve context information
 * specific to the blockchain environment the contract is operating in.
 */
library MockPyth {
    address constant HEVM_ADDRESS = address(bytes20(uint160(uint256(keccak256("hevm cheat code")))));
    Vm constant vm = Vm(HEVM_ADDRESS);

    struct Context {
        PythUpgradable pythUpgradable;
    }

    /**
     * @dev Mocks oracle data for testing purposes. This function allows simulating oracle data
     * within a test environment, enabling the testing of contract interactions with oracles.
     * @param pid The price feed ID of the oracle data to mock.
     * @param pythPriceFeed The pyth price { int64 price, uint64 conf, int32 expo, uint256 publishTime }
     */
    function mockOracleData(bytes32 pid, PythUpgradable.PriceFeed memory pythPriceFeed) internal {
        Context memory context = context();
        require(context.pythUpgradable.priceFeedExists(pid), "PythOracle: Price feed not found");

        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.queryPriceFeed.selector, pid),
            abi.encode(pythPriceFeed)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getPrice.selector, pid),
            abi.encode(pythPriceFeed.price)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getPriceUnsafe.selector, pid),
            abi.encode(pythPriceFeed.price)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getPriceNoOlderThan.selector, pid),
            abi.encode(pythPriceFeed.price)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getEmaPrice.selector, pid),
            abi.encode(pythPriceFeed.emaPrice)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getEmaPriceUnsafe.selector, pid),
            abi.encode(pythPriceFeed.emaPrice)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getEmaPriceNoOlderThan.selector, pid),
            abi.encode(pythPriceFeed.emaPrice)
        );
    }

    /**
     * @dev Mocks oracle data for testing purposes. This function allows simulating oracle data
     * within a test environment, enabling the testing of contract interactions with oracles.
     * @param pid The price feed ID of the oracle data to mock.
     * @param price The price of the base token in terms of the quote token.
     */
    function mockOracleData(bytes32 pid, int64 price) internal {
        Context memory context = context();
        require(context.pythUpgradable.priceFeedExists(pid), "PythOracle: Price feed not found");

        PythUpgradable.PriceFeed memory pythPriceFeed = context.pythUpgradable.queryPriceFeed(pid);
        pythPriceFeed.price.price = price;
        pythPriceFeed.emaPrice.price = price;

        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.queryPriceFeed.selector, pid),
            abi.encode(pythPriceFeed)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getPrice.selector, pid),
            abi.encode(pythPriceFeed.price)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getPriceUnsafe.selector, pid),
            abi.encode(pythPriceFeed.price)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getPriceNoOlderThan.selector, pid),
            abi.encode(pythPriceFeed.price)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getEmaPrice.selector, pid),
            abi.encode(pythPriceFeed.emaPrice)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getEmaPriceUnsafe.selector, pid),
            abi.encode(pythPriceFeed.emaPrice)
        );
        vm.mockCall(
            address(context.pythUpgradable),
            abi.encodePacked(PythUpgradable.getEmaPriceNoOlderThan.selector, pid),
            abi.encode(pythPriceFeed.emaPrice)
        );
    }

    /**
     * @dev Retrieves the context information relevant to the current blockchain environment.
     * This function checks the chain ID and returns the corresponding context information,
     * allowing the contract to adapt to different blockchain environments.
     * @return Context The context information for the current blockchain.
     */
    function context() public view returns (Context memory) {
        address pythUpgradable;

        if (block.chainid == 1) {
            // Ethereum mainnet
            pythUpgradable = 0x4305FB66699C3B2702D4d05CF36551390A4c69C6;
        } else if (block.chainid == 25) {
            // Cronos
            pythUpgradable = 0xE0d0e68297772Dd5a1f1D99897c581E2082dbA5B;
        } else if (block.chainid == 56) {
            // BNB
            pythUpgradable = 0x4D7E825f80bDf85e913E0DD2A2D54927e9dE1594;
        } else if (block.chainid == 69) {
            // Optimism
            pythUpgradable = 0xff1a0f4744e8582DF1aE09D5611b887B6a12925C;
        } else if (block.chainid == 82) {
            // Meter
            pythUpgradable = 0xbFe3f445653f2136b2FD1e6DdDb5676392E3AF16;
        } else if (block.chainid == 100) {
            // Gnosis
            pythUpgradable = 0x2880aB155794e7179c9eE2e38200202908C17B43;
        } else if (block.chainid == 137) {
            // Polygon
            pythUpgradable = 0xff1a0f4744e8582DF1aE09D5611b887B6a12925C;
        } else if (block.chainid == 148) {
            // Shimmer
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 169) {
            // Manta
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 199) {
            // BTTC
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 250) {
            // Fantom
            pythUpgradable = 0xff1a0f4744e8582DF1aE09D5611b887B6a12925C;
        } else if (block.chainid == 288) {
            // Boba
            pythUpgradable = 0x4374e5a8b9C22271E9EB878A2AA31DE97DF15DAF;
        } else if (block.chainid == 314) {
            // Filecoin
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 321) {
            // KCC
            pythUpgradable = 0xE0d0e68297772Dd5a1f1D99897c581E2082dbA5B;
        } else if (block.chainid == 324) {
            // zkSync Era
            pythUpgradable = 0xf087c864AEccFb6A2Bf1Af6A0382B0d0f6c5D834;
        } else if (block.chainid == 919) {
            // Mode
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 1030) {
            // Conflux eSpace
            pythUpgradable = 0xe9d69CdD6Fe41e7B621B4A688C5D1a68cB5c8ADc;
        } else if (block.chainid == 1101) {
            // Polygon zkEVM
            pythUpgradable = 0xC5E56d6b40F3e3B5fbfa266bCd35C37426537c65;
        } else if (block.chainid == 1111) {
            // WEMIX
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 1116) {
            // Core DAO
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 1890) {
            // LightLink Phoenix
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 2020) {
            // Ronin
            pythUpgradable = 0x2880aB155794e7179c9eE2e38200202908C17B43;
        } else if (block.chainid == 2222) {
            // Kava
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 5000) {
            // Mantle
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 7000) {
            // zetachain
            pythUpgradable = 0x2880aB155794e7179c9eE2e38200202908C17B43;
        } else if (block.chainid == 7332) {
            // Horizen EON
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 7700) {
            // Canto
            pythUpgradable = 0x98046Bd286715D3B0BC227Dd7a956b83D8978603;
        } else if (block.chainid == 8453) {
            // Base
            pythUpgradable = 0x8250f4aF4B972684F7b336503E2D6dFeDeB1487a;
        } else if (block.chainid == 9001) {
            // EVMOS
            pythUpgradable = 0x354bF866A4B006C9AF9d9e06d9364217A8616E12;
        } else if (block.chainid == 15557) {
            // EOS
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 42161) {
            // Arbitrum
            pythUpgradable = 0xff1a0f4744e8582DF1aE09D5611b887B6a12925C;
        } else if (block.chainid == 42220) {
            // Celo
            pythUpgradable = 0xff1a0f4744e8582DF1aE09D5611b887B6a12925C;
        } else if (block.chainid == 42766) {
            // ZKFair
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 43114) {
            // Avalanche
            pythUpgradable = 0x4305FB66699C3B2702D4d05CF36551390A4c69C6;
        } else if (block.chainid == 59144) {
            // Linea
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 88880) {
            // Chiliz
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 534351) {
            // Scroll
            pythUpgradable = 0xA2aa501b19aff244D90cc15a4Cf739D2725B5729;
        } else if (block.chainid == 245022934) {
            // Neon
            pythUpgradable = 0x7f2dB085eFC3560AFF33865dD727225d91B4f9A5;
        } else if (block.chainid == 1313161554) {
            // Aurora
            pythUpgradable = 0xF89C7b475821EC3fDC2dC8099032c05c6c0c9AB9;
        } else {
            revert("PythOracle: Chain not supported");
        }

        return Context(PythUpgradable(pythUpgradable));
    }
}

library PriceFeeds {
    bytes32 constant Crypto_1INCH_USD = 0x63f341689d98a12ef60a5cff1d7f85c70a9e17bf1575f0e7c0b2512d48b1c8b3;
    bytes32 constant Crypto_AAVE_USD = 0x2b9ab1e972a281585084148ba1389800799bd4be63b957507db1349314e47445;
    bytes32 constant Crypto_ACM_USD = 0xbd640cddb72063e2ede34c6a0baf6699759b9837fcb06aa0e2fbcecb9b65fde7;
    bytes32 constant Crypto_ADA_USD = 0x2a01deaec9e51a579277b34b122399984d0bbf57e2458a7e42fecd2829867a0d;
    bytes32 constant Crypto_AGEUR_USD = 0x3b670a7aa22cf0dc3b76b42dc2e26a85bac35eafc5a5ae2defd6d98201b1b997;
    bytes32 constant Crypto_AKT_USD = 0x4ea5bb4d2f5900cc2e97ba534240950740b4d3b89fe712a94a7304fd2fd92702;
    bytes32 constant Crypto_ALGO_USD = 0xfa17ceaf30d19ba51112fdcc750cc83454776f47fb0112e4af07f15f4bb1ebc0;
    bytes32 constant Crypto_ALICE_USD = 0xccca1d2b0d9a9ca72aa2c849329520a378aea0ec7ef14497e67da4050d6cf578;
    bytes32 constant Crypto_ALPACA_USD = 0x9095653620547ece988ec51486dc7a6eb2efddbce8ea5bedbd53bf00cca84cf6;
    bytes32 constant Crypto_ALPINE_USD = 0x97d7d4c20e5a06fdb60f7a448a9e9a779f2b31c3f21121180010a4a470844aae;
    bytes32 constant Crypto_AMB_USD = 0xbe4cb6bf8f18e84b1c4fd6fafa7f048a972be26505bd58338eb66c80faa99483;
    bytes32 constant Crypto_AMP_USD = 0xd37e4513ebe235fff81e453d400debaf9a49a5df2b7faa11b3831d35d7e72cb7;
    bytes32 constant Crypto_ANC_USD = 0x6d0af467543fc7daedf7abed96423877560c8d03725f3e5c87516774982a679c;
    bytes32 constant Crypto_ANKR_USD = 0x89a58e1cab821118133d6831f5018fba5b354afb78b2d18f575b3cbf69a4f652;
    bytes32 constant Crypto_APE_USD = 0x15add95022ae13563a11992e727c91bdb6b55bc183d9d747436c80a483d8c864;
    bytes32 constant Crypto_APT_USD = 0x03ae4db29ed4ae33d323568895aa00337e658e348b37509f5372ae51f0af00d5;
    bytes32 constant Crypto_AR_USD = 0xf610eae82767039ffc95eef8feaeddb7bbac0673cfe7773b2fde24fd1adb0aee;
    bytes32 constant Crypto_ARB_USD = 0x3fa4252848f9f0a1480be62745a4629d9eb1322aebab8a791e344b3b9c1adcf5;
    bytes32 constant Crypto_ARG_USD = 0x2394ce86c7d68050ce52797923860f6c1656a73fb11bd10dacb3f9c719acdd1d;
    bytes32 constant Crypto_ARKM_USD = 0x7677dd124dee46cfcd46ff03cf405fb0ed94b1f49efbea3444aadbda939a7ad3;
    bytes32 constant Crypto_ASR_USD = 0xb881c6dad5dd3dc9a83222f8032fb439859288119afc742d43adc305cef151cc;
    bytes32 constant Crypto_ASTR_USD = 0x89b814de1eb2afd3d3b498d296fca3a873e644bafb587e84d181a01edd682853;
    bytes32 constant Crypto_ATLAS_USD = 0x681e0eb7acf9a2a3384927684d932560fb6f67c6beb21baa0f110e993b265386;
    bytes32 constant Crypto_ATM_USD = 0x8ff1200345393bb25be4f4eeb2d97234e91f7e6213f3745a694b1436e700f271;
    bytes32 constant Crypto_ATOM_USD = 0xb00b60f88b03a6a625a8d1c048c3f66653edf217439983d037e7222c4e612819;
    bytes32 constant Crypto_AURORA_USD = 0x2f7c4f738d498585065a4b87b637069ec99474597da7f0ca349ba8ac3ba9cac5;
    bytes32 constant Crypto_AUTO_USD = 0xc7c60099c12805bea1ae4df2243d6fe72b63be3adeb2208195e844734219967b;
    bytes32 constant Crypto_AVAX_USD = 0x93da3352f9f1d105fdfe4971cfa80e9dd777bfc5d0f683ebb6e1294b92137bb7;
    bytes32 constant Crypto_AXL_USD = 0x60144b1d5c9e9851732ad1d9760e3485ef80be39b984f6bf60f82b28a2b7f126;
    bytes32 constant Crypto_AXS_USD = 0xb7e3904c08ddd9c0c10c6d207d390fd19e87eb6aab96304f571ed94caebdefa0;
    bytes32 constant Crypto_BAL_USD = 0x07ad7b4a7662d19a6bc675f6b467172d2f3947fa653ca97555a9b20236406628;
    bytes32 constant Crypto_BAND_USD = 0x5ab188823c117b3ac791391752f95fd701d923ccffa3436ecf7ba5d4bb4bd678;
    bytes32 constant Crypto_BAR_USD = 0x9d23a47f843f5c9284832ae6e76e4aa067dc6072a58f151d39a65a4cc792ef9f;
    bytes32 constant Crypto_BAT_USD = 0x8e860fb74e60e5736b455d82f60b3728049c348e94961add5f961b02fdee2535;
    bytes32 constant Crypto_BCH_USD = 0x3dd2b63686a450ec7290df3a1e0b583c0481f651351edfa7636f39aed55cf8a3;
    bytes32 constant Crypto_BETH_USD = 0x7f981f906d7cfe93f618804f1de89e0199ead306edc022d3230b3e8305f391b0;
    bytes32 constant Crypto_BIFI_USD = 0x70cd05521e3bdeaee2cadc1360f0d95397f03275f273199be35a029114f53a3b;
    bytes32 constant Crypto_BLUR_USD = 0x856aac602516addee497edf6f50d39e8c95ae5fb0da1ed434a8c2ab9c3e877e9;
    bytes32 constant Crypto_BLZE_USD = 0x93c3def9b169f49eed14c9d73ed0e942c666cf0e1290657ec82038ebb792c2a8;
    bytes32 constant Crypto_BNB_USD = 0x2f95862b045670cd22bee3114c39763a4a08beeb663b145d283c31d7d1101c4f;
    bytes32 constant Crypto_BNX_USD = 0x59671f59d12dc81bae078754b7469c7434528a66d3fa91193cf204460c198f9b;
    bytes32 constant Crypto_BOBA_USD = 0xd1e9cff9b8399f9867819a3bf1aa8c2598234eecfd36ddc3a7bc7848432184b5;
    bytes32 constant Crypto_BONK_USD = 0x72b021217ca3fe68922a19aaf990109cb9d84e9ad004b4d2025ad6f529314419;
    bytes32 constant Crypto_BOO_USD = 0x46a89b09e545ad5ccebee43198e70876c22a0621ff9f1dc8525aef2cffc52d2b;
    bytes32 constant Crypto_BRZ_USD = 0x1ce9069708fb49e2f1b062fa4f1be0bb151475ca506939d6d8c14386d49f43dc;
    bytes32 constant Crypto_BSOL_USD = 0x89875379e70f8fbadc17aef315adf3a8d5d160b811435537e03c97e8aac97d9c;
    bytes32 constant Crypto_BSV_USD = 0xb44565b8b9b39ab2f4ba792f1c8f8aa8ef7d780e709b191637ef886d96fd1472;
    bytes32 constant Crypto_BSW_USD = 0x48ce0cf436bac22dad33551dfe2eb7bf9991e419a05f25aed4e90c29c3a1cdbe;
    bytes32 constant Crypto_BTC_USD = 0xe62df6c8b4a85fe1a67db44dc12de5db330f7ac66b72dc658afedf0f4a415b43;
    bytes32 constant Crypto_BTT_USD = 0x097d687437374051c75160d648800f021086bc8edf469f11284491fda8192315;
    bytes32 constant Crypto_C98_USD = 0x2dd14c7c38aa7066c7a508aac299ebcde5165b07d5d9f2d94dfbfe41f0bc5f2e;
    bytes32 constant Crypto_CAKE_USD = 0x2356af9529a1064d41e32d617e2ce1dca5733afa901daba9e2b68dee5d53ecf9;
    bytes32 constant Crypto_CANTO_USD = 0x972776d57490d31c32279c16054e5c01160bd9a2e6af8b58780c82052b053549;
    bytes32 constant Crypto_CBETH_USD = 0x15ecddd26d49e1a8f1de9376ebebc03916ede873447c1255d2d5891b92ce5717;
    bytes32 constant Crypto_CEL_USD = 0x43d353c44e2e273d3e2480ff5538eb80f7c2857d7645926b2c845d7c188a9143;
    bytes32 constant Crypto_CELO_USD = 0x7d669ddcdd23d9ef1fa9a9cc022ba055ec900e91c4cb960f3c20429d4447a411;
    bytes32 constant Crypto_CELR_USD = 0x20841878a1c4d3ea4587603e2cb55b32afae64402f281652f5a3b94155ff27e9;
    bytes32 constant Crypto_CETUS_USD = 0xe5b274b2611143df055d6e7cd8d93fe1961716bcd4dca1cad87a83bc1e78c1ef;
    bytes32 constant Crypto_CFX_USD = 0x8879170230c9603342f3837cf9a8e76c61791198fb1271bb2552c9af7b33c933;
    bytes32 constant Crypto_CHR_USD = 0xbd4dbcbfd90e6bc6c583e07ffcb5cb6d09a0c7b1221805211ace08c837859627;
    bytes32 constant Crypto_CHZ_USD = 0xe799f456b358a2534aa1b45141d454ac04b444ed23b1440b778549bb758f2b5c;
    bytes32 constant Crypto_CITY_USD = 0x9c479b12a2b2c1051715d4d462dd7a6abbb6dccabf3af31a53f6130a1cd88efc;
    bytes32 constant Crypto_COMP_USD = 0x4a8e42861cabc5ecb50996f92e7cfa2bce3fd0a2423b0c44c9b423fb2bd25478;
    bytes32 constant Crypto_CORE_USD = 0x9b4503710cc8c53f75c30e6e4fda1a7064680ef2e0ee97acd2e3a7c37b3c830c;
    bytes32 constant Crypto_COW_USD = 0x4e53c6ef1f2f9952facdcf64551edb6d2a550985484ccce6a0477cae4c1bca3e;
    bytes32 constant Crypto_CRO_USD = 0x23199c2bcb1303f667e733b9934db9eca5991e765b45f5ed18bc4b231415f2fe;
    bytes32 constant Crypto_CRV_USD = 0xa19d04ac696c7a6616d291c7e5d1377cc8be437c327b75adb5dc1bad745fcae8;
    bytes32 constant Crypto_CTSI_USD = 0x14eb6f846b84f37c841ce7a52a38706e54966df84b3a09cc40499b164af05672;
    bytes32 constant Crypto_CUSD_USD = 0x8f218655050a1476b780185e89f19d2b1e1f49e9bd629efad6ac547a946bf6ab;
    bytes32 constant Crypto_CVX_USD = 0x6aac625e125ada0d2a6b98316493256ca733a5808cd34ccef79b0e28c64d1e76;
    bytes32 constant Crypto_DAI_USD = 0xb0948a5e5313200c632b51bb5ca32f6de0d36e9950a942d19751e833f70dabfd;
    bytes32 constant Crypto_DAR_USD = 0xd57d90cd8554ea0cf8268de30d5ad67fed9a8f11cce5132a49eb687aed832ea6;
    bytes32 constant Crypto_DODO_USD = 0x688aa41b26a19db08855aaf87723a0eda91b8a830b782c3215bca3b208fad81a;
    bytes32 constant Crypto_DOGE_USD = 0xdcef50dd0a4cd2dcc17e45df1676dcb336a11a61c69df7a0299b0150c672d25c;
    bytes32 constant Crypto_DOT_USD = 0xca3eed9b267293f6595901c734c7525ce8ef49adafe8284606ceb307afa2ca5b;
    bytes32 constant Crypto_DYDX_USD = 0x6489800bb8974169adfe35937bf6736507097d13c190d760c557108c7e93a81b;
    bytes32 constant Crypto_EGLD_USD = 0xee326a761a4b53629a29fc64bf47dda18cb2eea0bef22da7144dbdc130d112fc;
    bytes32 constant Crypto_ELON_USD = 0xc9cf25cd0df326b7fb3548b37d38e1e5c6ba202188a44ad98b79335c2b202f7b;
    bytes32 constant Crypto_ENJ_USD = 0x5cc254b7cb9532df39952aee2a6d5497b42ec2d2330c7b76147f695138dbd9f3;
    bytes32 constant Crypto_ENS_USD = 0xb98ab6023650bd2edc026b983fb7c2f8fa1020286f1ba6ecf3f4322cd83b72a6;
    bytes32 constant Crypto_EOS_USD = 0x06ade621dbc31ed0fc9255caaab984a468abe84164fb2ccc76f02a4636d97e31;
    bytes32 constant Crypto_ETC_USD = 0x7f5cc8d963fc5b3d2ae41fe5685ada89fd4f14b435f8050f28c7fd409f40c2d8;
    bytes32 constant Crypto_ETH_BTC = 0xc96458d393fe9deb7a7d63a0ac41e2898a67a7750dbd166673279e06c868df0a;
    bytes32 constant Crypto_ETH_USD = 0xff61491a931112ddf1bd8147cd1b641375f79f5825126d665480874634fd0ace;
    bytes32 constant Crypto_EURC_USD = 0x76fa85158bf14ede77087fe3ae472f66213f6ea2f5b411cb2de472794990fa5c;
    bytes32 constant Crypto_EVMOS_USD = 0xc19405e4c8bdcbf2a66c37ae05a27d385c8309e9d648ed20dc6ee717e7d30e17;
    bytes32 constant Crypto_FDUSD_USD = 0xccdc1a08923e2e4f4b1e6ea89de6acbc5fe1948e9706f5604b8cb50bc1ed3979;
    bytes32 constant Crypto_FET_USD = 0xb98e7ae8af2d298d2651eb21ab5b8b5738212e13efb43bd0dfbce7a74ba4b5d0;
    bytes32 constant Crypto_FIDA_USD = 0xc80657b7f6f3eac27218d09d5a4e54e47b25768d9f5e10ac15fe2cf900881400;
    bytes32 constant Crypto_FIL_USD = 0x150ac9b959aee0051e4091f0ef5216d941f590e1c5e7f91cf7635b5c11628c0e;
    bytes32 constant Crypto_FLOKI_USD = 0x6b1381ce7e874dc5410b197ac8348162c0dd6c0d4c9cd6322672d6c2b1d58293;
    bytes32 constant Crypto_FLOW_USD = 0x2fb245b9a84554a0f15aa123cbb5f64cd263b59e9a87d80148cbffab50c69f30;
    bytes32 constant Crypto_FTM_USD = 0x5c6c0d2386e3352356c3ab84434fafb5ea067ac2678a38a338c4a69ddc4bdb0c;
    bytes32 constant Crypto_FTT_USD = 0x6c75e52531ec5fd3ef253f6062956a8508a2f03fa0a209fb7fbc51efd9d35f88;
    bytes32 constant Crypto_FXS_USD = 0x735f591e4fed988cd38df74d8fcedecf2fe8d9111664e0fd500db9aa78b316b1;
    bytes32 constant Crypto_GAL_USD = 0x301377b122716cee1a498e7930a1836c0b1db84667cc78bbbcbad6c330ea6afb;
    bytes32 constant Crypto_GALA_USD = 0x0781209c28fda797616212b7f94d77af3a01f3e94a5d421760aef020cf2bcb51;
    bytes32 constant Crypto_GF_USD = 0xc358405df462d0eb57db14ebe01b917383ff81f2234ca99f8a57d7fb599cb83b;
    bytes32 constant Crypto_GLMR_USD = 0x309d39a65343d45824f63dc6caa75dbf864834f48cfaa6deb122c62239e06474;
    bytes32 constant Crypto_GMT_USD = 0xbaa284eaf23edf975b371ba2818772f93dbae72836bbdea28b07d40f3cf8b485;
    bytes32 constant Crypto_GMX_USD = 0xb962539d0fcb272a494d65ea56f94851c2bcf8823935da05bd628916e2e9edbf;
    bytes32 constant Crypto_GNO_USD = 0xc5f60d00d926ee369ded32a38a6bd5c1e0faa936f91b987a5d0dcf3c5d8afab0;
    bytes32 constant Crypto_GNS_USD = 0x5a5d5f7fb72cc84b579d74d1c06d258d751962e9a010c0b1cce7e6023aacb71b;
    bytes32 constant Crypto_GRAIL_USD = 0x48f3736d94693aa73c11214c4176ba7f997a8329f4dbc3854c4b2686861132ce;
    bytes32 constant Crypto_GRT_USD = 0x4d1f8dae0d96236fb98e8f47471a366ec3b1732b47041781934ca3a9bb2f35e7;
    bytes32 constant Crypto_GT_USD = 0x051ee6cdd581106d0291dfd9b0ee13e6b4dde8fb251afd262c2ba5444257daa8;
    bytes32 constant Crypto_GUSD_USD = 0xe186e116f2c7642d0d8aa89c32345d83ebeb350242b2274c46a19ea82e04fb8d;
    bytes32 constant Crypto_HBAR_USD = 0x3728e591097635310e6341af53db8b7ee42da9b3a8d918f9463ce9cca886dfbd;
    bytes32 constant Crypto_HFT_USD = 0xfa2d39b681f3cef5fa87432a8dbd05113917fffb1b6829a37395c88396522a4e;
    bytes32 constant Crypto_HNT_USD = 0x649fdd7ec08e8e2a20f425729854e90293dcbe2376abc47197a14da6ff339756;
    bytes32 constant Crypto_HT_USD = 0x38e91ba416e6010735d7580472784a3e0821ab559aacdf73f5aba9d661e687ab;
    bytes32 constant Crypto_ICP_USD = 0xc9907d786c5821547777780a1e4f89484f3417cb14dd244f2b0a34ea7a554d67;
    bytes32 constant Crypto_IDEX_USD = 0x6fdf9f1b31f6212aad9125dbc9d85ae6cfac3939fd914f6a8c397f01272eca8f;
    bytes32 constant Crypto_IMX_USD = 0x941320a8989414874de5aa2fc340a75d5ed91fdff1613dd55f83844d52ea63a2;
    bytes32 constant Crypto_INJ_USD = 0x7a5bc1d2b56ad029048cd63964b3ad2776eadf812edc1a43a31406cb54bff592;
    bytes32 constant Crypto_INTER_USD = 0xa4702f0f5818258783a1e47f453cb20b0fbec32ca67260e1d19dfcdd6a4d0ebb;
    bytes32 constant Crypto_IOTA_USD = 0xc7b72e5d860034288c9335d4d325da4272fe50c92ab72249d58f6cbba30e4c44;
    bytes32 constant Crypto_ITA_USD = 0xa5eb88d3ea93f6240d7e54b4466bc1857f7bfc1658d49a07f68096ebc0fdde3b;
    bytes32 constant Crypto_JITOSOL_USD = 0x67be9f519b95cf24338801051f9a808eff0a578ccb388db73b7f6fe1de019ffb;
    bytes32 constant Crypto_JOE_USD = 0xa3f37baf54dbd24e1d67040d566a762e62be3edbf8ef423038b091afc1722915;
    bytes32 constant Crypto_JST_USD = 0xee42016c303126bd9263724e00f83a8114e84518c6e8ffc9738c001cc301daff;
    bytes32 constant Crypto_JTO_USD = 0xb43660a5f790c69354b0729a5ef9d50d68f1df92107540210b9cccba1f947cc2;
    bytes32 constant Crypto_JUV_USD = 0xabe4f2b264560a397f38eec024369356e5c1ea4f7aab94729369f144b3d97779;
    bytes32 constant Crypto_KAVA_USD = 0xa6e905d4e85ab66046def2ef0ce66a7ea2a60871e68ae54aed50ec2fd96d8584;
    bytes32 constant Crypto_KCS_USD = 0xc8acad81438490d4ebcac23b3e93f31cdbcb893fcba746ea1c66b89684faae2f;
    bytes32 constant Crypto_KLAY_USD = 0xde5e6ef09931fecc7fdd8aaa97844e981f3e7bb1c86a6ffc68e9166bb0db3743;
    bytes32 constant Crypto_KNC_USD = 0xb9ccc817bfeded3926af791f09f76c5ffbc9b789cac6e9699ec333a79cacbe2a;
    bytes32 constant Crypto_KSM_USD = 0xdedebc9e4d916d10b76cfbc21ccaacaf622ab1fc7f7ba586a0de0eba76f12f3f;
    bytes32 constant Crypto_LAZIO_USD = 0xd1d95644ffc11ca502f21e067a7814144c56b37018515ced4335a886a827a305;
    bytes32 constant Crypto_LDO_USD = 0xc63e2a7f37a04e5e614c07238bedb25dcc38927fba8fe890597a593c0b2fa4ad;
    bytes32 constant Crypto_LEO_USD = 0x19e4e2b451406cf99311bb5127b12a948db17f30b69c323c8657d71119a58619;
    bytes32 constant Crypto_LINK_USD = 0x8ac0c70fff57e9aefdf5edf44b51d62c2d433653cbb2cf5cc06bb115af04d221;
    bytes32 constant Crypto_LOOKS_USD = 0xacecdd9ac741a1f6dad0fd6ade5354e9523bd0c864b955307cea3643fdfe8ff5;
    bytes32 constant Crypto_LRC_USD = 0x20311405c2fc648cf5733197e95c03512af9cf64f2260aea7e212a8c8b7bdcfa;
    bytes32 constant Crypto_LST_USD = 0x12fb674ee496045b1d9cf7d5e65379acb026133c2ad69f3ed996fb9fe68e3a37;
    bytes32 constant Crypto_LTC_USD = 0x6e3f3fa8253588df9326580180233eb791e03b443a3ba7a1d892e73874e19a54;
    bytes32 constant Crypto_LUNA_USD = 0xe6ccd3f878cf338e6732bf59f60943e8ca2c28402fc4d9c258503b2edbe74a31;
    bytes32 constant Crypto_LUNC_USD = 0x4456d442a152fd1f972b18459263ef467d3c29fb9d667e30c463b086691fbc79;
    bytes32 constant Crypto_LUSD_USD = 0xc9dc99720306ef43fd301396a6f8522c8be89c6c77e8c27d87966918a943fd20;
    bytes32 constant Crypto_MANA_USD = 0x1dfffdcbc958d732750f53ff7f06d24bb01364b3f62abea511a390c74b8d16a5;
    bytes32 constant Crypto_MANTA_USD = 0xc3883bcf1101c111e9fcfe2465703c47f2b638e21fef2cce0502e6c8f416e0e2;
    bytes32 constant Crypto_MASK_USD = 0xb97d9aa5c9ea258252456963c3a9547d53e4848cb66ce342a3155520741a28d4;
    bytes32 constant Crypto_MATIC_USD = 0x5de33a9112c2b700b8d30b8a3402c103578ccfa2765696471cc672bd5cf6ac52;
    bytes32 constant Crypto_MAV_USD = 0x5b131ede5d017511cf5280b9ebf20708af299266a033752b64180c4201363b11;
    bytes32 constant Crypto_MBOX_USD = 0x1888f463c27997174f97d2a36af29bf4648b61a5f69e67c45505a80f826bb785;
    bytes32 constant Crypto_MEAN_USD = 0x27d108eb764c912f49d3453a21dd95516619b1c45d0b607ee58a137ac8a6f32d;
    bytes32 constant Crypto_MEME_USD = 0xcd2cee36951a571e035db0dfad138e6ecdb06b517cc3373cd7db5d3609b7927c;
    bytes32 constant Crypto_MINA_USD = 0xe322f437708e16b033d785fceb5c7d61c94700364281a10fabc77ca20ef64bf1;
    bytes32 constant Crypto_MIR_USD = 0x0b46c1c04e9c914037cc4e0561a7e6787f6db0b89b7b65281f0f6fea1ce45a74;
    bytes32 constant Crypto_MKR_USD = 0x9375299e31c0deb9c6bc378e6329aab44cb48ec655552a70d4b9050346a30378;
    bytes32 constant Crypto_MNDE_USD = 0x3607bf4d7b78666bd3736c7aacaf2fd2bc56caa8667d3224971ebe3c0623292a;
    bytes32 constant Crypto_MNGO_USD = 0x5b70af49d639eefe11f20df47a0c0760123291bb5bc55053faf797d1ff905983;
    bytes32 constant Crypto_MNT_USD = 0x4e3037c822d852d79af3ac80e35eb420ee3b870dca49f9344a38ef4773fb0585;
    bytes32 constant Crypto_MOBILE_USD = 0xff4c53361e36a9b837433c87d290c229e1f01aec5ef98d9f3f70953a20a629ce;
    bytes32 constant Crypto_MSOL_USD = 0xc2289a6a43d2ce91c6f55caec370f4acc38a2ed477f58813334c6d03749ff2a4;
    bytes32 constant Crypto_MTR_USD = 0x8cdc9b2118d2ce55a299f8f1d700d0127cf4036d1aa666a8cd51dcab4254284f;
    bytes32 constant Crypto_MTRG_USD = 0x20d096e088a9b85f8cf09278965b77aeb05c00769e2ddeda5ea2d07ea554b283;
    bytes32 constant Crypto_NEAR_USD = 0xc415de8d2eba7db216527dff4b60e8f3a5311c740dadb233e13e12547e226750;
    bytes32 constant Crypto_NEON_USD = 0xd82183dd487bef3208a227bb25d748930db58862c5121198e723ed0976eb92b7;
    bytes32 constant Crypto_NFT_USD = 0xd64da7f265f00c456c2ebadf4593848129b9c86b45523e441d2f5ceb838a89cf;
    bytes32 constant Crypto_NTRN_USD = 0xa8e6517966a52cb1df864b2764f3629fde3f21d2b640b5c572fcd654cbccd65e;
    bytes32 constant Crypto_OG_USD = 0x05934526b94a9fbe4c4ce0c3792213032f086ee4bf58f2168a7085361af9bdc1;
    bytes32 constant Crypto_OKB_USD = 0xd6f83dfeaff95d596ddec26af2ee32f391c206a183b161b7980821860eeef2f5;
    bytes32 constant Crypto_OMG_USD = 0x3b4e266cfd796c642603073a8471f1bdb876a9c03ded525e4472a722298c4219;
    bytes32 constant Crypto_OMI_USD = 0x06d9fa501fd2bef47265361ca0eaf6e0a97c3b226cea5ab760240f70818581ad;
    bytes32 constant Crypto_ONDO_USD = 0xd40472610abe56d36d065a0cf889fc8f1dd9f3b7f2a478231a5fc6df07ea5ce3;
    bytes32 constant Crypto_ONE_USD = 0xc572690504b42b57a3f7aed6bd4aae08cbeeebdadcf130646a692fe73ec1e009;
    bytes32 constant Crypto_OP_USD = 0x385f64d993f7b77d8182ed5003d97c60aa3361f3cecfe711544d2d59165e9bdf;
    bytes32 constant Crypto_ORCA_USD = 0x37505261e557e251290b8c8899453064e8d760ed5c65a779726f2490980da74c;
    bytes32 constant Crypto_ORDI_USD = 0x193c739db502aadcef37c2589738b1e37bdb257d58cf1ab3c7ebc8e6df4e3ec0;
    bytes32 constant Crypto_OSMO_USD = 0x5867f5683c757393a0670ef0f701490950fe93fdb006d181c8265a831ac0c5c6;
    bytes32 constant Crypto_OUSD_USD = 0xbfaf61069ca9164aba41935fa16488ce7c39b313e7faaa02fb4655b99caada05;
    bytes32 constant Crypto_PAXG_USD = 0x273717b49430906f4b0c230e99aa1007f83758e3199edbc887c0d06c3e332494;
    bytes32 constant Crypto_PENDLE_USD = 0x9a4df90b25497f66b1afb012467e316e801ca3d839456db028892fe8c70c8016;
    bytes32 constant Crypto_PEOPLE_USD = 0xb7fe919d83815ca6074c82a3286b1cd6ffb7d3136e323cd2b1ef706cfc7e5945;
    bytes32 constant Crypto_PEPE_USD = 0xd69731a2e74ac1ce884fc3890f7ee324b6deb66147055249568869ed700882e4;
    bytes32 constant Crypto_PERP_USD = 0x944f2f908c5166e0732ea5b610599116cd8e1c41f47452697c1e84138b7184d6;
    bytes32 constant Crypto_POL_USD = 0xffd11c5a1cfd42f80afb2df4d9f264c15f956d68153335374ec10722edd70472;
    bytes32 constant Crypto_POR_USD = 0x701223c92a39dbab065c4a7997fef9c41c8de26ca2bf1f808ce0a4ea1cfd421f;
    bytes32 constant Crypto_PORT_USD = 0x0afa3199e0899270a74ddcf5cc960d3c6c4414b4ca71024af1a62786dd24f52a;
    bytes32 constant Crypto_PORTO_USD = 0x88e2d5cbd2474766abffb2a67a58755a2cc19beb3b309e1ded1e357253aa3623;
    bytes32 constant Crypto_PRIME_USD = 0xe417fb7d1edcfe70283c608fa9f14d11ebf4d1b3ecf2e97e42a110f7fb649843;
    bytes32 constant Crypto_PSG_USD = 0x3d253019d38099c0fe918291bd08c9b887f4306a44d7d472c8031529141f275a;
    bytes32 constant Crypto_PYTH_USD = 0x0bbf28e9a841a1cc788f6a361b17ca072d0ea3098a1e5df1c3922d06719579ff;
    bytes32 constant Crypto_PYUSD_USD = 0xc1da1b73d7f01e7ddd54b3766cf7fcd644395ad14f70aa706ec5384c59e76692;
    bytes32 constant Crypto_QNT_USD = 0x19ab139032007c8bd7d1fd3842ef392a5434569a72b555504a5aee47df2a0a35;
    bytes32 constant Crypto_RACA_USD = 0xfd0690232b0fae5efdc402c1b9aac74176383ff7daf87d021554bda24a38e0ec;
    bytes32 constant Crypto_RAY_USD = 0x91568baa8beb53db23eb3fb7f22c6e8bd303d103919e19733f2bb642d3e7987a;
    bytes32 constant Crypto_RDNT_USD = 0xc8cf45412be4268bef8f76a8b0d60971c6e57ab57919083b8e9f12ba72adeeb6;
    bytes32 constant Crypto_RETH_USD = 0xa0255134973f4fdf2f8f7808354274a3b1ebc6ee438be898d045e8b56ba1fe13;
    bytes32 constant Crypto_RLB_USD = 0x2f2d17abbc1e781bd87b4a5d52c8b2856886f5c482fa3593cebf6795040ab0b6;
    bytes32 constant Crypto_RNDR_USD = 0xab7347771135fc733f8f38db462ba085ed3309955f42554a14fa13e855ac0e2f;
    bytes32 constant Crypto_RON_USD = 0x97cfe19da9153ef7d647b011c5e355142280ddb16004378573e6494e499879f3;
    bytes32 constant Crypto_RPL_USD = 0x24f94ac0fd8638e3fc41aab2e4df933e63f763351b640bf336a6ec70651c4503;
    bytes32 constant Crypto_RUNE_USD = 0x5fcf71143bb70d41af4fa9aa1287e2efd3c5911cee59f909f915c9f61baacb1e;
    bytes32 constant Crypto_SAMO_USD = 0x49601625e1a342c1f90c3fe6a03ae0251991a1d76e480d2741524c29037be28a;
    bytes32 constant Crypto_SAND_USD = 0xcb7a1d45139117f8d3da0a4b67264579aa905e3b124efede272634f094e1e9d1;
    bytes32 constant Crypto_SANTOS_USD = 0x26d53c97247ec18d576bbd23f88078acc22b42168dcb1d29a76501a956e26bad;
    bytes32 constant Crypto_SBR_USD = 0x6ed3c7c4427ae2f91707495fc5a891b30795d93dbb3931782ddd77a5d8cb6db7;
    bytes32 constant Crypto_SCNSOL_USD = 0x1021a42d623ab4fe0bf8c47fd21cc10636e39e07f91e9b2478551e137d512aaa;
    bytes32 constant Crypto_SEI_USD = 0x53614f1cb0c031d4af66c04cb9c756234adad0e1cee85303795091499a4084eb;
    bytes32 constant Crypto_SFP_USD = 0xc9e9d228f565c226dfb8ed5f5c9c4f57ab32b7ade7226c3239ff20911a9c3a7b;
    bytes32 constant Crypto_SHIB_USD = 0xf0d57deca57b3da2fe63a493f4c25925fdfd8edf834b20f93e1f84dbd1504d4a;
    bytes32 constant Crypto_SKL_USD = 0x597d2ae7e4b92165d40f03ae57895e3e8245762a177b6db3274e4322b78f5b82;
    bytes32 constant Crypto_SLND_USD = 0xf8d030e4ef460b91ad23eabbbb27aec463e3c30ecc8d5c4b71e92f54a36ccdbd;
    bytes32 constant Crypto_SLP_USD = 0xfba17701be318087db58d9797d5f1e89dcf5b95773ae2227c8a8eb4cf1d4e554;
    bytes32 constant Crypto_SMR_USD = 0xaf5b9ac426ae79591fde6816bc3f043b5e06d5e442f52112f76249320df22449;
    bytes32 constant Crypto_SNX_USD = 0x39d020f60982ed892abbcd4a06a276a9f9b7bfbce003204c110b6e488f502da3;
    bytes32 constant Crypto_SNY_USD = 0x9fb0bd29fe51481b61df41e650346cc374b13c2bab2e3610364cd834a592025a;
    bytes32 constant Crypto_SOL_USD = 0xef0d8b6fda2ceba41da15d4095d1da392a0d2f8ed0c6c7bc0f4cfac8c280b56d;
    bytes32 constant Crypto_SPA_USD = 0xcdaf63079d7abee0f54344fb19bf4e23d1e6c8ff7d8e820c86ce119b0ddc14cd;
    bytes32 constant Crypto_SPELL_USD = 0x1dcf38b0206d27849b0fcb8d2df21aff4f95873cce223f49d7c1ea3c5145ec63;
    bytes32 constant Crypto_SRM_USD = 0x23245bb74254e65a98cc3ff4a37443d79f527e44e449750ad304538b006f21bc;
    bytes32 constant Crypto_STETH_ETH = 0x3af6a3098c56f58ff47cc46dee4a5b1910e5c157f7f0b665952445867470d61f;
    bytes32 constant Crypto_STETH_USD = 0x846ae1bdb6300b817cee5fdee2a6da192775030db5615b94a465f53bd40850b5;
    bytes32 constant Crypto_STORJ_USD = 0x21776e4ed1e763d580071fd6394d71e582672c788f64f4a279e60ec1497e27c4;
    bytes32 constant Crypto_STSOL_USD = 0xa1a6465f4c2ebf244c31d80bc95c27345a3424e428c2def33eced9e90d3f701b;
    bytes32 constant Crypto_STX_USD = 0xec7a775f46379b5e943c3526b1c8d54cd49749176b0b98e02dde68d1bd335c17;
    bytes32 constant Crypto_SUI_USD = 0x23d7315113f5b1d3ba7a83604c44b94d79f4fd69af77f804fc7f920a6dc65744;
    bytes32 constant Crypto_SUN_USD = 0x159b09ed169a3cdbd13fd96ef4b3cda54972058906d38a58f5cd327e5df1478b;
    bytes32 constant Crypto_SUSHI_USD = 0x26e4f737fde0263a9eea10ae63ac36dcedab2aaf629261a994e1eeb6ee0afe53;
    bytes32 constant Crypto_SWEAT_USD = 0x432a52bde005a010dc32c47733e4595fea0ea04df3b5aaa1c45153a527d646f0;
    bytes32 constant Crypto_TBTC_USD = 0x56a3121958b01f99fdc4e1fd01e81050602c7ace3a571918bb55c6a96657cca9;
    bytes32 constant Crypto_TENET_USD = 0x29429344e993184204b4d484a8322c7bd221a7e4aebf354ddf6c3d230e141822;
    bytes32 constant Crypto_THETA_USD = 0xee70804471fe22d029ac2d2b00ea18bbf4fb062958d425e5830fd25bed430345;
    bytes32 constant Crypto_THG_USD = 0xa639c04942ebfdeabf25bf1b88d6608ef387219748d77ea130bc2fa486b9614f;
    bytes32 constant Crypto_TIA_USD = 0x09f7c1d7dfbb7df2b8fe3d3d87ee94a2259d212da4f30c1f0540d066dfa44723;
    bytes32 constant Crypto_TLM_USD = 0x4457960559b812558bb0f8cb7912f8bcb843eb801a3133ef45be998630ff8c05;
    bytes32 constant Crypto_TON_USD = 0x8963217838ab4cf5cadc172203c1f0b763fbaa45f346d8ee50ba994bbcac3026;
    bytes32 constant Crypto_TRB_USD = 0xddcd037c2de8dbf2a0f6eebf1c039924baf7ebf0e7eb3b44bf421af69cc1b06d;
    bytes32 constant Crypto_TRX_USD = 0x67aed5a24fdad045475e7195c98a98aea119c763f272d4523f5bac93a4f33c2b;
    bytes32 constant Crypto_TURBOS_USD = 0xf9c2e890443dd995d0baafc08eea3358be1ffb874f93f99c30b3816c460bbac3;
    bytes32 constant Crypto_TUSD_USD = 0x433faaa801ecdb6618e3897177a118b273a8e18cc3ff545aadfc207d58d028f7;
    bytes32 constant Crypto_TWT_USD = 0x35f1e0d9248599d276111821c0fd636b43eef18737c3bb61c7c5c47059787a32;
    bytes32 constant Crypto_UMA_USD = 0x4b78d251770732f6304b1f41e9bebaabc3b256985ef18988f6de8d6562dd254c;
    bytes32 constant Crypto_UNI_USD = 0x78d185a741d07edb3412b09008b7c5cfb9bbbd7d568bf00ba737b456ba171501;
    bytes32 constant Crypto_UNIBOT_USD = 0x62e158019396bf8405824b858452a1d7cc6dbb95f2e54c5641b60bb94d1f614a;
    bytes32 constant Crypto_USDC_USD = 0xeaa020c61cc479712813461ce153894a96a6c00b21ed0cfc2798d1f9a9e9c94a;
    bytes32 constant Crypto_USDD_USD = 0x6d20210495d6518787b72e4ad06bc4df21e68d89a802cf6bced2fca6c29652a6;
    bytes32 constant Crypto_USDP_USD = 0xa6c8eca9aea31d6bb81fd6576638f30692d4afaa73237c097c193477aa5003b3;
    bytes32 constant Crypto_USDT_USD = 0x2b89b9dc8fdf9f34709a5b106b472f0f39bb6ca9ce04b0fd7f2e971688e2e53b;
    bytes32 constant Crypto_USTC_USD = 0xef94acc2fb09eb976c6eb3000bab898cab891d5b800702cd1dc88e61d7c3c5e6;
    bytes32 constant Crypto_VAI_USD = 0x7507a4629ad0143550666bce2e7cae0b961a0f624f821feaab642fe1be632f5c;
    bytes32 constant Crypto_VELA_USD = 0x4b1ddc065d08214eb06878d6130a66665febc3fd201733e9bb481094b5de8a32;
    bytes32 constant Crypto_VET_USD = 0x1722176f738aa1aafea170f8b27724042c5ac6d8cb9cf8ae02d692b0927e0681;
    bytes32 constant Crypto_VIC_USD = 0xf80ba6864e3f1b36c873bcb2767079d5fb86cf04855e714b2a0f30d7e0830a24;
    bytes32 constant Crypto_WAVES_USD = 0x70dddcb074263ce201ea9a1be5b3537e59ed5b9060d309e12d61762cfe59fb7e;
    bytes32 constant Crypto_WBTC_USD = 0xc9d8b075a5c69303365ae23633d4e085199bf5c520a3b90fed1322a0342ffc33;
    bytes32 constant Crypto_WEMIX_USD = 0xf63f008474fad630207a1cfa49207d59bca2593ea64fc0a6da9bf3337485791c;
    bytes32 constant Crypto_WIN_USD = 0xb216f7ca372b318985903866e0b6dc44a14564828c49f36d0d363805aa76335c;
    bytes32 constant Crypto_WLD_USD = 0xd6835ad1f773de4a378115eb6824bd0c0e42d84d1c84d9750e853fb6b6c7794a;
    bytes32 constant Crypto_WOJAK_USD = 0x6e89dbed2351e3c85a9ce1c782ca1e34b6ef2c4775f1cb691739bbe6d0697e86;
    bytes32 constant Crypto_WOM_USD = 0x43cddc3e1d0b17fec1cf2a230f46e9319887a037dcee56e053af44d8259fb042;
    bytes32 constant Crypto_WOO_USD = 0xb82449fd728133488d2d41131cffe763f9c1693b73c544d9ef6aaa371060dd25;
    bytes32 constant Crypto_WSTETH_USD = 0x6df640f3b8963d8f8358f791f352b8364513f6ab1cca5ed3f1f7b5448980e784;
    bytes32 constant Crypto_XAUT_USD = 0x44465e17d2e9d390e70c999d5a11fda4f092847fcd2e3e5aa089d96c98a30e67;
    bytes32 constant Crypto_XLM_USD = 0xb7a8eba68a997cd0210c2e1e4ee811ad2d174b3611c22d9ebf16f4cb7e9ba850;
    bytes32 constant Crypto_XMR_USD = 0x46b8cc9347f04391764a0361e0b17c3ba394b001e7c304f7650f6376e37c321d;
    bytes32 constant Crypto_XPRT_USD = 0x9f520bbc39aad043e3bbb46b05079222d63bd94c150205f2a8889b6b36a0f376;
    bytes32 constant Crypto_XRD_USD = 0x816c6604beb161d3ad9c3b584f06c682e6299516165d756a68c7660b073b7072;
    bytes32 constant Crypto_XRP_USD = 0xec5d399846a9209f3fe5881d70aae9268c94339ff9817e8d18ff19fa05eea1c8;
    bytes32 constant Crypto_XTZ_USD = 0x0affd4b8ad136a21d79bc82450a325ee12ff55a235abc242666e423b8bcffd03;
    bytes32 constant Crypto_XVS_USD = 0x831624f51c7bd4499fe5e0f16dfa2fd22584ae4bdc496bbbbe9ba831b2d9bce9;
    bytes32 constant Crypto_XWG_USD = 0x83a6de4ec10bce1c0515d1aac082fd193f268f0c3b62da0c8ed1286319272415;
    bytes32 constant Crypto_YFI_USD = 0x425f4b198ab2504936886c1e93511bb6720fbcf2045a4f3c0723bb213846022f;
    bytes32 constant Crypto_ZBC_USD = 0x26852e2d0696e25e6adaad2d7ca3a1f2f15aab68d317ace14d41b4128a7e780f;
    bytes32 constant Crypto_ZEC_USD = 0xbe9b59d178f0d6a97ab4c343bff2aa69caa1eaae3e9048a65788c529b125bb24;
    bytes32 constant Crypto_ZEN_USD = 0xd183ffe0155e8a55e7274155a14ea2e8b54059cef471f88fa3f7eb4b5d8dbc24;
    bytes32 constant Crypto_ZIL_USD = 0x609722f3b6dc10fee07907fe86781d55eb9121cd0705b480954c00695d78f0cb;
    bytes32 constant Crypto_ZRX_USD = 0x7d17b9fe4ea7103be16b6836984fabbc889386d700ca5e5b3d34b7f92e449268;
    bytes32 constant Equity_US_AAPL_USD = 0x49f6b65cb1de6b10eaf75e7c03ca029c306d0357e91b5311b175084a5ad55688;
    bytes32 constant Equity_US_AI_USD = 0xafb12c5ccf50495c7a7b04447410d7feb4b3218a663ecbd96aa82e676d3c4f1e;
    bytes32 constant Equity_US_AMC_USD = 0x5b1703d7eb9dc8662a61556a2ca2f9861747c3fc803e01ba5a8ce35cb50a13a1;
    bytes32 constant Equity_US_AMGN_USD = 0x10946973bfcc936b423d52ee2c5a538d96427626fe6d1a7dae14b1c401d1e794;
    bytes32 constant Equity_US_AMZN_USD = 0xb5d0e0fa58a1f8b81498ae670ce93c872d14434b72c364885d4fa1b257cbb07a;
    bytes32 constant Equity_US_ARKK_USD = 0xb2fe0af6c828efefda3ffda664f919825a535aa28a0f19fc238945c7aff540b1;
    bytes32 constant Equity_US_AXP_USD = 0x9ff7b9a93df40f6d7edc8184173c50f4ae72152c6142f001e8202a26f951d710;
    bytes32 constant Equity_US_BA_USD = 0x8419416ba640c8bbbcf2d464561ed7dd860db1e38e51cec9baf1e34c4be839ae;
    bytes32 constant Equity_US_BLK_USD = 0x68d038affb5895f357d7b3527a6d3cd6a54edd0fe754a1248fb3462e47828b08;
    bytes32 constant Equity_US_CAT_USD = 0xad04597ba688c350a97265fcb60585d6a80ebd37e147b817c94f101a32e58b4c;
    bytes32 constant Equity_US_COIN_USD = 0xfee33f2a978bf32dd6b662b65ba8083c6773b494f8401194ec1870c640860245;
    bytes32 constant Equity_US_CPNG_USD = 0x5557d206aa0dd037fc082f03bbd78653f01465d280ea930bc93251f0eb60c707;
    bytes32 constant Equity_US_CRM_USD = 0xfeff234600320f4d6bb5a01d02570a9725c1e424977f2b823f7231e6857bdae8;
    bytes32 constant Equity_US_CSCO_USD = 0x3f4b77dd904e849f70e1e812b7811de57202b49bc47c56391275c0f45f2ec481;
    bytes32 constant Equity_US_CVX_USD = 0xf464e36fd4ef2f1c3dc30801a9ab470dcdaaa0af14dd3cf6ae17a7fca9e051c5;
    bytes32 constant Equity_US_DIS_USD = 0x703e36203020ae6761e6298975764e266fb869210db9b35dd4e4225fa68217d0;
    bytes32 constant Equity_US_DOW_USD = 0xf3b50961ff387a3d68217e2715637d0add6013e7ecb83c36ae8062f97c46929e;
    bytes32 constant Equity_US_EEM_USD = 0xd407e68cec58205be82a6140a668dc42f8d9079bcf3be4aa4b41f41f7b983035;
    bytes32 constant Equity_US_EFA_USD = 0x3b7ef6c95ceedbffbb66bff3d6135a200c5d0a0466b0c90812510ceaedebaf04;
    bytes32 constant Equity_US_GE_USD = 0xe1d3115c6e7ac649faca875b3102f1000ab5e06b03f6903e0d699f0f5315ba86;
    bytes32 constant Equity_US_GLD_USD = 0xe190f467043db04548200354889dfe0d9d314c08b8d4e62fabf4d5a3140fecca;
    bytes32 constant Equity_US_GME_USD = 0x6f9cd89ef1b7fd39f667101a91ad578b6c6ace4579d5f7f285a4b06aa4504be6;
    bytes32 constant Equity_US_GOOG_USD = 0xe65ff435be42630439c96396653a342829e877e2aafaeaf1a10d0ee5fd2cf3f2;
    bytes32 constant Equity_US_GOVT_USD = 0xe0f87bbde799f33615b83a601b66415e850788000cd7286a3e7295f23c1bb353;
    bytes32 constant Equity_US_GS_USD = 0x9c68c0c6999765cf6e27adf75ed551b34403126d3b0d5b686a2addb147ed4554;
    bytes32 constant Equity_US_HD_USD = 0xb3a83dbe70b62241b0f916212e097465a1b31085fa30da3342dd35468ca17ca5;
    bytes32 constant Equity_US_HON_USD = 0x107918baaaafb79cd9df1c8369e44ac21136d95f3ca33f2373b78f24ba1e3e6a;
    bytes32 constant Equity_US_HYG_USD = 0x2077043ee3b67b9a70949c8396c110f6cf43de8e6d9e6efdcbd557a152cf2c6e;
    bytes32 constant Equity_US_IBM_USD = 0xcfd44471407f4da89d469242546bb56f5c626d5bef9bd8b9327783065b43c3ef;
    bytes32 constant Equity_US_INTC_USD = 0xc1751e085ee292b8b3b9dd122a135614485a201c35dfc653553f0e28c1baf3ff;
    bytes32 constant Equity_US_IVV_USD = 0x5967c196ca33171a0b2d140ddc6334b998dd71c2ddd85ba7920c35fd6ed20fe9;
    bytes32 constant Equity_US_IWM_USD = 0xeff690a187797aa225723345d4612abec0bf0cec1ae62347c0e7b1905d730879;
    bytes32 constant Equity_US_JNJ_USD = 0x12848738d5db3aef52f51d78d98fc8b8b8450ffb19fb3aeeb67d38f8c147ff63;
    bytes32 constant Equity_US_JPM_USD = 0x7f4f157e57bfcccd934c566df536f34933e74338fe241a5425ce561acdab164e;
    bytes32 constant Equity_US_KO_USD = 0x9aa471dccea36b90703325225ac76189baf7e0cc286b8843de1de4f31f9caa7d;
    bytes32 constant Equity_US_MCD_USD = 0xd3178156b7c0f6ce10d6da7d347952a672467b51708baaf1a57ffe1fb005824a;
    bytes32 constant Equity_US_META_USD = 0x78a3e3b8e676a8f73c439f5d749737034b139bbbe899ba5775216fba596607fe;
    bytes32 constant Equity_US_MINT_USD = 0x58f4ee3a0fc4de834a2e96274a696d0f3d8ec45fc76131a6a49fcd18d3ca9812;
    bytes32 constant Equity_US_MMM_USD = 0xfd05a384ba19863cbdfc6575bed584f041ef50554bab3ab482eabe4ea58d9f81;
    bytes32 constant Equity_US_MRK_USD = 0xc81114e16ec3cbcdf20197ac974aed5a254b941773971260ce09e7caebd6af46;
    bytes32 constant Equity_US_MSFT_USD = 0xd0ca23c1cc005e004ccf1db5bf76aeb6a49218f43dac3d4b275e92de12ded4d1;
    bytes32 constant Equity_US_MSTR_USD = 0xe1e80251e5f5184f2195008382538e847fafc36f751896889dd3d1b1f6111f09;
    bytes32 constant Equity_US_NFLX_USD = 0x8376cfd7ca8bcdf372ced05307b24dced1f15b1afafdeff715664598f15a3dd2;
    bytes32 constant Equity_US_NKE_USD = 0x67649450b4ca4bfff97cbaf96d2fd9e40f6db148cb65999140154415e4378e14;
    bytes32 constant Equity_US_NVDA_USD = 0xb1073854ed24cbc755dc527418f52b7d271f6cc967bbf8d8129112b18860a593;
    bytes32 constant Equity_US_PG_USD = 0xad2fda41998f4e7be99a2a7b27273bd16f183d9adfc014a4f5e5d3d6cd519bf4;
    bytes32 constant Equity_US_QQQ_USD = 0x9695e2b96ea7b3859da9ed25b7a46a920a776e2fdae19a7bcfdf2b219230452d;
    bytes32 constant Equity_US_SHV_USD = 0x765f416f2d676848b5016428bc9295fda3e71d5e97b16df75179a378cef040ec;
    bytes32 constant Equity_US_SPY_USD = 0x19e09bb805456ada3979a7d1cbb4b6d63babc3a0f8e8a9509f68afa5c4c11cd5;
    bytes32 constant Equity_US_TLT_USD = 0x9f383d612ac09c7e6ffda24deca1502fce72e0ba58ff473fea411d9727401cc1;
    bytes32 constant Equity_US_TRV_USD = 0xd45392f678a1287b8412ed2aaa326def204a5c234df7cb5552d756c332283d81;
    bytes32 constant Equity_US_TSLA_USD = 0x16dad506d7db8da01c87581c87ca897a012a153557d4d578c3b9c9e1bc0632f1;
    bytes32 constant Equity_US_UNH_USD = 0x05380f8817eb1316c0b35ac19c3caa92c9aa9ea6be1555986c46dce97fed6afd;
    bytes32 constant Equity_US_USO_USD = 0xd00bd77d97dc5769de77f96d0e1a79cbf1364e14d0dbf046e221bce2e89710dd;
    bytes32 constant Equity_US_V_USD = 0xc719eb7bab9b2bc060167f1d1680eb34a29c490919072513b545b9785b73ee90;
    bytes32 constant Equity_US_VOO_USD = 0x236b30dd09a9c00dfeec156c7b1efd646c0f01825a1758e3e4a0679e3bdff179;
    bytes32 constant Equity_US_VZ_USD = 0x6672325a220c0ee1166add709d5ba2e51c185888360c01edc76293257ef68b58;
    bytes32 constant Equity_US_WBA_USD = 0xed5c2a2711e2a638573add9a8aded37028aea4ac69f1431a1ced9d9db61b2225;
    bytes32 constant Equity_US_WMT_USD = 0x327ae981719058e6fb44e132fb4adbf1bd5978b43db0661bfdaefd9bea0c82dc;
    bytes32 constant Equity_US_XLE_USD = 0x8bf649e08e5a86129c57990556c8eec30e296069b524f4639549282bc5c07bb4;
    bytes32 constant FX_AUD_USD = 0x67a6f93030420c1c9e3fe37c1ab6b77966af82f995944a9fefce357a22854a80;
    bytes32 constant FX_EUR_USD = 0xa995d00bb36a63cef7fd2c287dc105fc8f3d93779f062f09551b0af3e81ec30b;
    bytes32 constant FX_GBP_USD = 0x84c2dde9633d93d1bcad84e7dc41c9d56578b7ec52fabedc1f335d673df0a7c1;
    bytes32 constant FX_NZD_USD = 0x92eea8ba1b00078cdc2ef6f64f091f262e8c7d0576ee4677572f314ebfafa4c7;
    bytes32 constant FX_USD_CAD = 0x3112b03a41c910ed446852aacf67118cb1bec67b2cd0b9a214c58cc0eaa2ecca;
    bytes32 constant FX_USD_CHF = 0x0b1e3297e69f162877b577b0d6a47a0d63b2392bc8499e6540da4187a63e28f8;
    bytes32 constant FX_USD_CNH = 0xeef52e09c878ad41f6a81803e3640fe04dceea727de894edd4ea117e2e332e66;
    bytes32 constant FX_USD_HKD = 0x19d75fde7fee50fe67753fdc825e583594eb2f51ae84e114a5246c4ab23aff4c;
    bytes32 constant FX_USD_JPY = 0xef2c98c804ba503c6a707e38be4dfbb16683775f195b091252bf24693042fd52;
    bytes32 constant FX_USD_MXN = 0xe13b1c1ffb32f34e1be9545583f01ef385fde7f42ee66049d30570dc866b77ca;
    bytes32 constant FX_USD_NOK = 0x235ddea9f40e9af5814dbcc83a418b98e3ee8df1e34e1ae4d45cf5de596023a3;
    bytes32 constant FX_USD_SEK = 0x8ccb376aa871517e807358d4e3cf0bc7fe4950474dbe6c9ffc21ef64e43fc676;
    bytes32 constant FX_USD_SGD = 0x396a969a9c1480fa15ed50bc59149e2c0075a72fe8f458ed941ddec48bdb4918;
    bytes32 constant FX_USD_ZAR = 0x389d889017db82bf42141f23b61b8de938a4e2d156e36312175bebf797f493f1;
    bytes32 constant Metal_XAG_USD = 0xf2fb02c32b055c805e7238d628e5e9dadef274376114eb1f012337cabe93871e;
    bytes32 constant Metal_XAU_USD = 0x765d2ba906dbc32ca17cc11f5310a89e9ee1f6420508c63861f2f8ba4ee34bb2;
}

interface PythUpgradable {
    type GovernanceAction is uint8;
    type GovernanceModule is uint8;

    struct AuthorizeGovernanceDataSourceTransferPayload {
        bytes claimVaa;
    }

    struct DataSource {
        uint16 chainId;
        bytes32 emitterAddress;
    }

    struct GovernanceInstruction {
        GovernanceModule module;
        GovernanceAction action;
        uint16 targetChainId;
        bytes payload;
    }

    struct Price {
        int64 price;
        uint64 conf;
        int32 expo;
        uint256 publishTime;
    }

    struct PriceFeed {
        bytes32 id;
        Price price;
        Price emaPrice;
    }

    struct RequestGovernanceDataSourceTransferPayload {
        uint32 governanceDataSourceIndex;
    }

    struct SetDataSourcesPayload {
        DataSource[] dataSources;
    }

    struct SetFeePayload {
        uint256 newFee;
    }

    struct SetValidPeriodPayload {
        uint256 newValidPeriod;
    }

    struct SetWormholeAddressPayload {
        address newWormholeAddress;
    }

    struct UpgradeContractPayload {
        address newImplementation;
    }

    error InsufficientFee();
    error InvalidArgument();
    error InvalidGovernanceDataSource();
    error InvalidGovernanceMessage();
    error InvalidGovernanceTarget();
    error InvalidUpdateData();
    error InvalidUpdateDataSource();
    error InvalidWormholeAddressToSet();
    error InvalidWormholeVaa();
    error NoFreshUpdate();
    error OldGovernanceMessage();
    error PriceFeedNotFound();
    error PriceFeedNotFoundWithinRange();
    error StalePrice();

    event AdminChanged(address previousAdmin, address newAdmin);
    event BatchPriceFeedUpdate(uint16 chainId, uint64 sequenceNumber);
    event BeaconUpgraded(address indexed beacon);
    event ContractUpgraded(address oldImplementation, address newImplementation);
    event DataSourcesSet(DataSource[] oldDataSources, DataSource[] newDataSources);
    event FeeSet(uint256 oldFee, uint256 newFee);
    event GovernanceDataSourceSet(DataSource oldDataSource, DataSource newDataSource, uint64 initialSequence);
    event Initialized(uint8 version);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event PriceFeedUpdate(bytes32 indexed id, uint64 publishTime, int64 price, uint64 conf);
    event Upgraded(address indexed implementation);
    event ValidPeriodSet(uint256 oldValidPeriod, uint256 newValidPeriod);
    event WormholeAddressSet(address oldWormholeAddress, address newWormholeAddress);

    function chainId() external view returns (uint16);
    function executeGovernanceInstruction(bytes memory encodedVM) external;
    function getEmaPrice(bytes32 id) external view returns (Price memory price);
    function getEmaPriceNoOlderThan(bytes32 id, uint256 age) external view returns (Price memory price);
    function getEmaPriceUnsafe(bytes32 id) external view returns (Price memory price);
    function getPrice(bytes32 id) external view returns (Price memory price);
    function getPriceNoOlderThan(bytes32 id, uint256 age) external view returns (Price memory price);
    function getPriceUnsafe(bytes32 id) external view returns (Price memory price);
    function getUpdateFee(bytes[] memory updateData) external view returns (uint256 feeAmount);
    function getUpdateFee(uint256 updateDataSize) external view returns (uint256 feeAmount);
    function getValidTimePeriod() external view returns (uint256);
    function governanceDataSource() external view returns (DataSource memory);
    function governanceDataSourceIndex() external view returns (uint32);
    function hashDataSource(DataSource memory ds) external pure returns (bytes32);
    function initialize(
        address wormhole,
        uint16[] memory dataSourceEmitterChainIds,
        bytes32[] memory dataSourceEmitterAddresses,
        uint16 governanceEmitterChainId,
        bytes32 governanceEmitterAddress,
        uint64 governanceInitialSequence,
        uint256 validTimePeriodSeconds,
        uint256 singleUpdateFeeInWei
    ) external;
    function isValidDataSource(uint16 dataSourceChainId, bytes32 dataSourceEmitterAddress)
        external
        view
        returns (bool);
    function isValidGovernanceDataSource(uint16 governanceChainId, bytes32 governanceEmitterAddress)
        external
        view
        returns (bool);
    function lastExecutedGovernanceSequence() external view returns (uint64);
    function latestPriceInfoPublishTime(bytes32 priceId) external view returns (uint64);
    function owner() external view returns (address);
    function parseAuthorizeGovernanceDataSourceTransferPayload(bytes memory encodedPayload)
        external
        pure
        returns (AuthorizeGovernanceDataSourceTransferPayload memory sgds);
    function parseGovernanceInstruction(bytes memory encodedInstruction)
        external
        pure
        returns (GovernanceInstruction memory gi);
    function parsePriceFeedUpdates(
        bytes[] memory updateData,
        bytes32[] memory priceIds,
        uint64 minPublishTime,
        uint64 maxPublishTime
    ) external payable returns (PriceFeed[] memory priceFeeds);
    function parseRequestGovernanceDataSourceTransferPayload(bytes memory encodedPayload)
        external
        pure
        returns (RequestGovernanceDataSourceTransferPayload memory sgdsClaim);
    function parseSetDataSourcesPayload(bytes memory encodedPayload)
        external
        pure
        returns (SetDataSourcesPayload memory sds);
    function parseSetFeePayload(bytes memory encodedPayload) external pure returns (SetFeePayload memory sf);
    function parseSetValidPeriodPayload(bytes memory encodedPayload)
        external
        pure
        returns (SetValidPeriodPayload memory svp);
    function parseSetWormholeAddressPayload(bytes memory encodedPayload)
        external
        pure
        returns (SetWormholeAddressPayload memory sw);
    function parseUpgradeContractPayload(bytes memory encodedPayload)
        external
        pure
        returns (UpgradeContractPayload memory uc);
    function priceFeedExists(bytes32 id) external view returns (bool);
    function proxiableUUID() external view returns (bytes32);
    function pythUpgradableMagic() external pure returns (uint32);
    function queryPriceFeed(bytes32 id) external view returns (PriceFeed memory priceFeed);
    function renounceOwnership() external;
    function singleUpdateFeeInWei() external view returns (uint256);
    function transferOwnership(address newOwner) external;
    function updatePriceFeeds(bytes[] memory updateData) external payable;
    function updatePriceFeedsIfNecessary(
        bytes[] memory updateData,
        bytes32[] memory priceIds,
        uint64[] memory publishTimes
    ) external payable;
    function upgradeTo(address newImplementation) external;
    function upgradeToAndCall(address newImplementation, bytes memory data) external payable;
    function validDataSources() external view returns (DataSource[] memory);
    function validTimePeriodSeconds() external view returns (uint256);
    function version() external pure returns (string memory);
    function wormhole() external view returns (address);
}
