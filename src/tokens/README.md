## Vulnerability Type
This template is for getting started with manipulating token balances. The token template wraps the forge `deal` cheatcode to allow `IERC20` objects to be passed. The following tokens from EVM based chains are included:

<details>
  <summary>

### Ethereum
  </summary>

| Network | Token | Address |
| ---------- | -------- | ------------------------------------------------------- |
| Ethereum | USDT     | [0xdAC17F958D2ee523a2206206994597C13D831ec7](https://etherscan.io/address/0xdAC17F958D2ee523a2206206994597C13D831ec7) |
| Ethereum | BNB      | [0xB8c77482e45F1F44dE1745F52C74426C631bDD52](https://etherscan.io/address/0xB8c77482e45F1F44dE1745F52C74426C631bDD52) |
| Ethereum | USDC     | [0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48](https://etherscan.io/address/0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48) |
| Ethereum | BUSD     | [0x4Fabb145d64652a948d72533023f6E7A623C7C53](https://etherscan.io/address/0x4Fabb145d64652a948d72533023f6E7A623C7C53) |
| Ethereum | MATIC    | [0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0](https://etherscan.io/address/0x7D1AfA7B718fb893dB30A3aBc0Cfc608AaCfeBB0) |
| Ethereum | OKB      | [0x75231F58b43240C9718Dd58B4967c5114342a86c](https://etherscan.io/address/0x75231F58b43240C9718Dd58B4967c5114342a86c) |
| Ethereum | stETH    | [0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84](https://etherscan.io/address/0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84) |
| Ethereum | anyLTC   | [0x0aBCFbfA8e3Fda8B7FBA18721Caf7d5cf55cF5f5](https://etherscan.io/address/0x0aBCFbfA8e3Fda8B7FBA18721Caf7d5cf55cF5f5) |
| Ethereum | THETA    | [0x3883f5e181fccaF8410FA61e12b59BAd963fb645](https://etherscan.io/address/0x3883f5e181fccaF8410FA61e12b59BAd963fb645) |
| Ethereum | SHIB     | [0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE](https://etherscan.io/address/0x95aD61b0a150d79219dCF64E1E6Cc01f0B64C4cE) |
| Ethereum | DAI      | [0x6B175474E89094C44Da98b954EedeAC495271d0F](https://etherscan.io/address/0x6B175474E89094C44Da98b954EedeAC495271d0F) |
| Ethereum | HEX      | [0x2b591e99afE9f32eAA6214f7B7629768c40Eeb39](https://etherscan.io/address/0x2b591e99afE9f32eAA6214f7B7629768c40Eeb39) |
| Ethereum | UNI      | [0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984](https://etherscan.io/address/0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984) |
| Ethereum | LEO      | [0x2AF5D2aD76741191D15Dfe7bF6aC92d4Bd912Ca3](https://etherscan.io/address/0x2AF5D2aD76741191D15Dfe7bF6aC92d4Bd912Ca3) |
| Ethereum | WBTC     | [0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599](https://etherscan.io/address/0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599) |
| Ethereum | LINK     | [0x514910771AF9Ca656af840dff83E8264EcF986CA](https://etherscan.io/address/0x514910771AF9Ca656af840dff83E8264EcF986CA) |
| Ethereum | QNT      | [0x4a220E6096B25EADb88358cb44068A3248254675](https://etherscan.io/address/0x4a220E6096B25EADb88358cb44068A3248254675) |
| Ethereum | APE      | [0x4d224452801ACEd8B2F0aebE155379bb5D594381](https://etherscan.io/address/0x4d224452801ACEd8B2F0aebE155379bb5D594381) |
| Ethereum | CRO      | [0xA0b73E1Ff0B80914AB6fe0444E65848C4C34450b](https://etherscan.io/address/0xA0b73E1Ff0B80914AB6fe0444E65848C4C34450b) |
| Ethereum | LDO      | [0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32](https://etherscan.io/address/0x5A98FcBEA516Cf06857215779Fd812CA3beF1B32) |
| Ethereum | NEAR     | [0x85F17Cf997934a597031b2E18a9aB6ebD4B9f6a4](https://etherscan.io/address/0x85F17Cf997934a597031b2E18a9aB6ebD4B9f6a4) |
| Ethereum | VEN      | [0xD850942eF8811f2A866692A623011bDE52a462C1](https://etherscan.io/address/0xD850942eF8811f2A866692A623011bDE52a462C1) |
| Ethereum | FRAX     | [0x853d955aCEf822Db058eb8505911ED77F175b99e](https://etherscan.io/address/0x853d955aCEf822Db058eb8505911ED77F175b99e) |
| Ethereum | aAAVE    | [0xba3D9687Cf50fE253cd2e1cFeEdE1d6787344Ed5](https://etherscan.io/address/0xba3D9687Cf50fE253cd2e1cFeEdE1d6787344Ed5) |
| Ethereum | stkAAVE  | [0x4da27a545c0c5B758a6BA100e3a049001de870f5](https://etherscan.io/address/0x4da27a545c0c5B758a6BA100e3a049001de870f5) |
| Ethereum | TUSD     | [0x0000000000085d4780B73119b644AE5ecd22b376](https://etherscan.io/address/0x0000000000085d4780B73119b644AE5ecd22b376) |
| Ethereum | USDP     | [0x8E870D67F660D95d5be530380D0eC0bd388289E1](https://etherscan.io/address/0x8E870D67F660D95d5be530380D0eC0bd388289E1) |
| Ethereum | SAND     | [0x3845badAde8e6dFF049820680d1F14bD3903a5d0](https://etherscan.io/address/0x3845badAde8e6dFF049820680d1F14bD3903a5d0) |
| Ethereum | HT       | [0x6f259637dcD74C767781E37Bc6133cd6A68aa161](https://etherscan.io/address/0x6f259637dcD74C767781E37Bc6133cd6A68aa161) |
| Ethereum | wMANA    | [0xFd09Cf7cFffa9932e33668311C4777Cb9db3c9Be](https://etherscan.io/address/0xFd09Cf7cFffa9932e33668311C4777Cb9db3c9Be) |
| Ethereum | USDD     | [0x0C10bF8FcB7Bf5412187A595ab97a3609160b5c6](https://etherscan.io/address/0x0C10bF8FcB7Bf5412187A595ab97a3609160b5c6) |
| Ethereum | KCS      | [0xf34960d9d60be18cC1D5Afc1A6F012A723a28811](https://etherscan.io/address/0xf34960d9d60be18cC1D5Afc1A6F012A723a28811) |
| Ethereum | BTT      | [0xC669928185DbCE49d2230CC9B0979BE6DC797957](https://etherscan.io/address/0xC669928185DbCE49d2230CC9B0979BE6DC797957) |
| Ethereum | CHZ      | [0x3506424F91fD33084466F402d5D97f05F8e3b4AF](https://etherscan.io/address/0x3506424F91fD33084466F402d5D97f05F8e3b4AF) |
| Ethereum | FTM      | [0x4E15361FD6b4BB609Fa63C81A2be19d873717870](https://etherscan.io/address/0x4E15361FD6b4BB609Fa63C81A2be19d873717870) |
| Ethereum | GUSD     | [0x056Fd409E1d7A124BD7017459dFEa2F387b6d5Cd](https://etherscan.io/address/0x056Fd409E1d7A124BD7017459dFEa2F387b6d5Cd) |
| Ethereum | MKR      | [0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2](https://etherscan.io/address/0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2) |
| Ethereum | cUSDC    | [0x39AA39c021dfbaE8faC545936693aC917d5E7563](https://etherscan.io/address/0x39AA39c021dfbaE8faC545936693aC917d5E7563) |
| Ethereum | GRT      | [0xc944E90C64B2c07662A292be6244BDf05Cda44a7](https://etherscan.io/address/0xc944E90C64B2c07662A292be6244BDf05Cda44a7) |
| Ethereum | PAXG     | [0x45804880De22913dAFE09f4980848ECE6EcbAf78](https://etherscan.io/address/0x45804880De22913dAFE09f4980848ECE6EcbAf78) |
| Ethereum | BIT      | [0x1A4b46696b2bB4794Eb3D4c26f1c55F9170fa4C5](https://etherscan.io/address/0x1A4b46696b2bB4794Eb3D4c26f1c55F9170fa4C5) |
| Ethereum | XAUt     | [0x68749665FF8D2d112Fa859AA293F07A622782F38](https://etherscan.io/address/0x68749665FF8D2d112Fa859AA293F07A622782F38) |
| Ethereum | cDAI     | [0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643](https://etherscan.io/address/0x5d3a536E4D6DbD6114cc1Ead35777bAB948E3643) |
| Ethereum | SNX      | [0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F](https://etherscan.io/address/0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F) |
| Ethereum | FXS      | [0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0](https://etherscan.io/address/0x3432B6A60D23Ca0dFCa7761B7ab56459D9C964D0) |
| Ethereum | NEXO     | [0xB62132e35a6c13ee1EE0f84dC5d40bad8d815206](https://etherscan.io/address/0xB62132e35a6c13ee1EE0f84dC5d40bad8d815206) |
| Ethereum | cETH     | [0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5](https://etherscan.io/address/0x4Ddc2D193948926D02f9B1fE9e1daa0718270ED5) |
| Ethereum | ZIL      | [0x05f4a42e251f2d52b8ed15E9FEdAacFcEF1FAD27](https://etherscan.io/address/0x05f4a42e251f2d52b8ed15E9FEdAacFcEF1FAD27) |
| Ethereum | XDCE     | [0x41AB1b6fcbB2fA9DCEd81aCbdeC13Ea6315F2Bf2](https://etherscan.io/address/0x41AB1b6fcbB2fA9DCEd81aCbdeC13Ea6315F2Bf2) |
| Ethereum | ONEINCH  | [0x111111111117dC0aa78b770fA6A738034120C302](https://etherscan.io/address/0x111111111117dC0aa78b770fA6A738034120C302) |
| Ethereum | steCRV   | [0x06325440D014e39736583c165C2963BA99fAf14E](https://etherscan.io/address/0x06325440D014e39736583c165C2963BA99fAf14E) |
| Ethereum | wstETH   | [0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0](https://etherscan.io/address/0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0) |
</details>
<details>
  <summary>

### Binance
  </summary>

| Network | Token | Address |
| ---------- | -------- | ------------------------------------------------------- |
| Binance | ETH      | [0x2170Ed0880ac9A755fd29B2688956BD959F933F8](https://bscscan.com/address/0x2170Ed0880ac9A755fd29B2688956BD959F933F8) |
| Binance | BSCUSD   | [0x55d398326f99059fF775485246999027B3197955](https://bscscan.com/address/0x55d398326f99059fF775485246999027B3197955) |
| Binance | WBNB     | [0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c](https://bscscan.com/address/0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c) |
| Binance | USDC     | [0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d](https://bscscan.com/address/0x8AC76a51cc950d9822D68b83fE1Ad97B32Cd580d) |
| Binance | anyUSDC  | [0x8965349fb649A33a30cbFDa057D8eC2C48AbE2A2](https://bscscan.com/address/0x8965349fb649A33a30cbFDa057D8eC2C48AbE2A2) |
| Binance | XRP      | [0x1D2F0da169ceB9fC7B3144628dB156f3F6c60dBE](https://bscscan.com/address/0x1D2F0da169ceB9fC7B3144628dB156f3F6c60dBE) |
| Binance | BUSD     | [0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56](https://bscscan.com/address/0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56) |
| Binance | ADA      | [0x3EE2200Efb3400fAbB9AacF31297cBdD1d435D47](https://bscscan.com/address/0x3EE2200Efb3400fAbB9AacF31297cBdD1d435D47) |
| Binance | DOGE     | [0xbA2aE424d960c26247Dd6c32edC70B295c744C43](https://bscscan.com/address/0xbA2aE424d960c26247Dd6c32edC70B295c744C43) |
| Binance | MATIC    | [0xCC42724C6683B7E57334c4E856f4c9965ED682bD](https://bscscan.com/address/0xCC42724C6683B7E57334c4E856f4c9965ED682bD) |
| Binance | LTC      | [0x4338665CBB7B2485A8855A139b75D5e34AB0DB94](https://bscscan.com/address/0x4338665CBB7B2485A8855A139b75D5e34AB0DB94) |
| Binance | DAI      | [0x1AF3F329e8BE154074D8769D1FFa4eE058B1DBc3](https://bscscan.com/address/0x1AF3F329e8BE154074D8769D1FFa4eE058B1DBc3) |
| Binance | DOT      | [0x7083609fCE4d1d8Dc0C979AAb8c869Ea2C873402](https://bscscan.com/address/0x7083609fCE4d1d8Dc0C979AAb8c869Ea2C873402) |
| Binance | SHIB     | [0x2859e4544C4bB03966803b044A93563Bd2D0DD4D](https://bscscan.com/address/0x2859e4544C4bB03966803b044A93563Bd2D0DD4D) |
| Binance | UNI      | [0xBf5140A22578168FD562DCcF235E5D43A02ce9B1](https://bscscan.com/address/0xBf5140A22578168FD562DCcF235E5D43A02ce9B1) |
| Binance | AVAX     | [0x1CE0c2827e2eF14D5C4f29a091d735A204794041](https://bscscan.com/address/0x1CE0c2827e2eF14D5C4f29a091d735A204794041) |
| Binance | ATOM     | [0x0Eb3a705fc54725037CC9e008bDede697f62F335](https://bscscan.com/address/0x0Eb3a705fc54725037CC9e008bDede697f62F335) |
| Binance | LINK     | [0xF8A0BF9cF54Bb92F17374d9e9A321E6a111a51bD](https://bscscan.com/address/0xF8A0BF9cF54Bb92F17374d9e9A321E6a111a51bD) |
| Binance | ETC      | [0x3d6545b08693daE087E957cb1180ee38B9e3c25E](https://bscscan.com/address/0x3d6545b08693daE087E957cb1180ee38B9e3c25E) |
| Binance | BTTp     | [0x8595F9dA7b868b1822194fAEd312235E43007b49](https://bscscan.com/address/0x8595F9dA7b868b1822194fAEd312235E43007b49) |
| Binance | BCH      | [0x8fF795a6F4D97E7887C79beA79aba5cc76444aDf](https://bscscan.com/address/0x8fF795a6F4D97E7887C79beA79aba5cc76444aDf) |
| Binance | NEAR     | [0x1Fa4a73a3F0133f0025378af00236f3aBDEE5D63](https://bscscan.com/address/0x1Fa4a73a3F0133f0025378af00236f3aBDEE5D63) |
| Binance | FRAX     | [0x90C97F71E18723b0Cf0dfa30ee176Ab653E89F40](https://bscscan.com/address/0x90C97F71E18723b0Cf0dfa30ee176Ab653E89F40) |
| Binance | EOS      | [0x56b6fB708fC5732DEC1Afc8D8556423A2EDcCbD6](https://bscscan.com/address/0x56b6fB708fC5732DEC1Afc8D8556423A2EDcCbD6) |
| Binance | PAX      | [0xb7F8Cd00C5A06c0537E2aBfF0b58033d02e5E094](https://bscscan.com/address/0xb7F8Cd00C5A06c0537E2aBfF0b58033d02e5E094) |
| Binance | BTCB     | [0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c](https://bscscan.com/address/0x7130d2A12B9BCbFAe4f2634d864A1Ee1Ce3Ead9c) |
| Binance | TUSD     | [0x14016E85a25aeb13065688cAFB43044C2ef86784](https://bscscan.com/address/0x14016E85a25aeb13065688cAFB43044C2ef86784) |
| Binance | AXS      | [0x715D400F88C167884bbCc41C5FeA407ed4D2f8A0](https://bscscan.com/address/0x715D400F88C167884bbCc41C5FeA407ed4D2f8A0) |
| Binance | EGLD     | [0xbF7c81FFF98BbE61B40Ed186e4AfD6DDd01337fe](https://bscscan.com/address/0xbF7c81FFF98BbE61B40Ed186e4AfD6DDd01337fe) |
| Binance | USDP     | [0xb3c11196A4f3b1da7c23d9FB0A3dDE9c6340934F](https://bscscan.com/address/0xb3c11196A4f3b1da7c23d9FB0A3dDE9c6340934F) |
| Binance | FLOW     | [0xC943c5320B9c18C153d1e2d12cC3074bebfb31A2](https://bscscan.com/address/0xC943c5320B9c18C153d1e2d12cC3074bebfb31A2) |
| Binance | XTZ      | [0x16939ef78684453bfDFb47825F8a5F714f12623a](https://bscscan.com/address/0x16939ef78684453bfDFb47825F8a5F714f12623a) |
| Binance | USDD     | [0xd17479997F34dd9156Deef8F95A52D81D265be9c](https://bscscan.com/address/0xd17479997F34dd9156Deef8F95A52D81D265be9c) |
| Binance | ZEC      | [0x1Ba42e5193dfA8B03D15dd1B86a3113bbBEF8Eeb](https://bscscan.com/address/0x1Ba42e5193dfA8B03D15dd1B86a3113bbBEF8Eeb) |
| Binance | SNX      | [0x9Ac983826058b8a9C7Aa1C9171441191232E8404](https://bscscan.com/address/0x9Ac983826058b8a9C7Aa1C9171441191232E8404) |
| Binance | TWT      | [0x4B0F1812e5Df2A09796481Ff14017e6005508003](https://bscscan.com/address/0x4B0F1812e5Df2A09796481Ff14017e6005508003) |
| Binance | BTT      | [0x352Cb5E19b12FC216548a2677bD0fce83BaE434B](https://bscscan.com/address/0x352Cb5E19b12FC216548a2677bD0fce83BaE434B) |
| Binance | MKR      | [0x5f0Da599BB2ccCfcf6Fdfd7D81743B6020864350](https://bscscan.com/address/0x5f0Da599BB2ccCfcf6Fdfd7D81743B6020864350) |
| Binance | FTM      | [0xAD29AbB318791D579433D831ed122aFeAf29dcfe](https://bscscan.com/address/0xAD29AbB318791D579433D831ed122aFeAf29dcfe) |
| Binance | IOTA     | [0xd944f1D1e9d5f9Bb90b62f9D45e447D989580782](https://bscscan.com/address/0xd944f1D1e9d5f9Bb90b62f9D45e447D989580782) |
| Binance | PAXG     | [0x7950865a9140cB519342433146Ed5b40c6F210f7](https://bscscan.com/address/0x7950865a9140cB519342433146Ed5b40c6F210f7) |
| Binance | XEC      | [0x0Ef2e7602adD1733Bfdb17aC3094d0421B502cA3](https://bscscan.com/address/0x0Ef2e7602adD1733Bfdb17aC3094d0421B502cA3) |
| Binance | FXS      | [0xe48A3d7d0Bc88d552f730B62c006bC925eadB9eE](https://bscscan.com/address/0xe48A3d7d0Bc88d552f730B62c006bC925eadB9eE) |
| Binance | ZIL      | [0xb86AbCb37C3A4B64f74f59301AFF131a1BEcC787](https://bscscan.com/address/0xb86AbCb37C3A4B64f74f59301AFF131a1BEcC787) |
| Binance | ETHW     | [0x302cD8973bE5CA2334B4ff7e7b01BA41455559b3](https://bscscan.com/address/0x302cD8973bE5CA2334B4ff7e7b01BA41455559b3) |
| Binance | ONEINCH  | [0x111111111117dC0aa78b770fA6A738034120C302](https://bscscan.com/address/0x111111111117dC0aa78b770fA6A738034120C302) |
| Binance | GALA     | [0x7dDEE176F665cD201F93eEDE625770E2fD911990](https://bscscan.com/address/0x7dDEE176F665cD201F93eEDE625770E2fD911990) |
| Binance | BAT      | [0x101d82428437127bF1608F699CD651e6Abf9766E](https://bscscan.com/address/0x101d82428437127bF1608F699CD651e6Abf9766E) |
| Binance | XCN      | [0x7324c7C0d95CEBC73eEa7E85CbAac0dBdf88a05b](https://bscscan.com/address/0x7324c7C0d95CEBC73eEa7E85CbAac0dBdf88a05b) |
| Binance | COMP     | [0x52CE071Bd9b1C4B00A0b92D298c512478CaD67e8](https://bscscan.com/address/0x52CE071Bd9b1C4B00A0b92D298c512478CaD67e8) |
</details>
<details>
  <summary>

### Polygon
  </summary>

| Network | Token | Address |
| ---------- | -------- | ------------------------------------------------------- |
| Polygon | USDT      | [0xc2132D05D31c914a87C6611C10748AEb04B58e8F](https://polygonscan.com/address/0xc2132D05D31c914a87C6611C10748AEb04B58e8F) |
| Polygon | BNB       | [0x3BA4c387f786bFEE076A58914F5Bd38d668B42c3](https://polygonscan.com/address/0x3BA4c387f786bFEE076A58914F5Bd38d668B42c3) |
| Polygon | USDC      | [0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174](https://polygonscan.com/address/0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174) |
| Polygon | BUSD      | [0xdAb529f40E671A1D4bF91361c21bf9f0C9712ab7](https://polygonscan.com/address/0xdAb529f40E671A1D4bF91361c21bf9f0C9712ab7) |
| Polygon | MATIC     | [0x0000000000000000000000000000000000001010](https://polygonscan.com/address/0x0000000000000000000000000000000000001010) |
| Polygon | DAI       | [0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063](https://polygonscan.com/address/0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063) |
| Polygon | UNI       | [0xb33EaAd8d922B1083446DC23f610c2567fB5180f](https://polygonscan.com/address/0xb33EaAd8d922B1083446DC23f610c2567fB5180f) |
| Polygon | AVAX      | [0x2C89bbc92BD86F8075d1DEcc58C7F4E0107f286b](https://polygonscan.com/address/0x2C89bbc92BD86F8075d1DEcc58C7F4E0107f286b) |
| Polygon | LEO       | [0x06D02e9D62A13fC76BB229373FB3BBBD1101D2fC](https://polygonscan.com/address/0x06D02e9D62A13fC76BB229373FB3BBBD1101D2fC) |
| Polygon | WBTC      | [0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6](https://polygonscan.com/address/0x1BFD67037B42Cf73acF2047067bd4F2C47D9BfD6) |
| Polygon | LINK      | [0xb0897686c545045aFc77CF20eC7A532E3120E0F1](https://polygonscan.com/address/0xb0897686c545045aFc77CF20eC7A532E3120E0F1) |
| Polygon | LINKb     | [0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39](https://polygonscan.com/address/0x53E0bca35eC356BD5ddDFebbD1Fc0fD03FaBad39) |
| Polygon | APE       | [0xB7b31a6BC18e48888545CE79e83E06003bE70930](https://polygonscan.com/address/0xB7b31a6BC18e48888545CE79e83E06003bE70930) |
| Polygon | CRO       | [0xAdA58DF0F643D959C2A47c9D4d4c1a4deFe3F11C](https://polygonscan.com/address/0xAdA58DF0F643D959C2A47c9D4d4c1a4deFe3F11C) |
| Polygon | LDO       | [0xC3C7d422809852031b44ab29EEC9F1EfF2A58756](https://polygonscan.com/address/0xC3C7d422809852031b44ab29EEC9F1EfF2A58756) |
| Polygon | FRAX      | [0x45c32fA6DF82ead1e2EF74d17b76547EDdFaFF89](https://polygonscan.com/address/0x45c32fA6DF82ead1e2EF74d17b76547EDdFaFF89) |
| Polygon | AAVE      | [0xD6DF932A45C0f255f85145f286eA0b292B21C90B](https://polygonscan.com/address/0xD6DF932A45C0f255f85145f286eA0b292B21C90B) |
| Polygon | TUSD      | [0x2e1AD108fF1D8C782fcBbB89AAd783aC49586756](https://polygonscan.com/address/0x2e1AD108fF1D8C782fcBbB89AAd783aC49586756) |
| Polygon | PAX       | [0x6F3B3286fd86d8b47EC737CEB3D0D354cc657B3e](https://polygonscan.com/address/0x6F3B3286fd86d8b47EC737CEB3D0D354cc657B3e) |
| Polygon | SAND      | [0xBbba073C31bF03b8ACf7c28EF0738DeCF3695683](https://polygonscan.com/address/0xBbba073C31bF03b8ACf7c28EF0738DeCF3695683) |
| Polygon | THETA     | [0xB46E0ae620EFd98516f49bb00263317096C114b2](https://polygonscan.com/address/0xB46E0ae620EFd98516f49bb00263317096C114b2) |
| Polygon | HT        | [0xFAD65Eb62a97fF5Ed91B23aFD039956aaCa6e93b](https://polygonscan.com/address/0xFAD65Eb62a97fF5Ed91B23aFD039956aaCa6e93b) |
| Polygon | MANA      | [0xA1c57f48F0Deb89f569dFbE6E2B7f46D33606fD4](https://polygonscan.com/address/0xA1c57f48F0Deb89f569dFbE6E2B7f46D33606fD4) |
| Polygon | USDD      | [0xFFA4D863C96e743A2e1513824EA006B8D0353C57](https://polygonscan.com/address/0xFFA4D863C96e743A2e1513824EA006B8D0353C57) |
| Polygon | CHZ       | [0xf1938Ce12400f9a761084E7A80d37e732a4dA056](https://polygonscan.com/address/0xf1938Ce12400f9a761084E7A80d37e732a4dA056) |
| Polygon | FTM       | [0xC9c1c1c20B3658F8787CC2FD702267791f224Ce1](https://polygonscan.com/address/0xC9c1c1c20B3658F8787CC2FD702267791f224Ce1) |
| Polygon | GUSD      | [0xC8A94a3d3D2dabC3C1CaffFFDcA6A7543c3e3e65](https://polygonscan.com/address/0xC8A94a3d3D2dabC3C1CaffFFDcA6A7543c3e3e65) |
| Polygon | MKR       | [0x6f7C932e7684666C9fd1d44527765433e01fF61d](https://polygonscan.com/address/0x6f7C932e7684666C9fd1d44527765433e01fF61d) |
| Polygon | GRT       | [0x5fe2B58c013d7601147DcdD68C143A77499f5531](https://polygonscan.com/address/0x5fe2B58c013d7601147DcdD68C143A77499f5531) |
| Polygon | PAXG      | [0x553d3D295e0f695B9228246232eDF400ed3560B5](https://polygonscan.com/address/0x553d3D295e0f695B9228246232eDF400ed3560B5) |
| Polygon | SNX       | [0x50B728D8D964fd00C2d0AAD81718b71311feF68a](https://polygonscan.com/address/0x50B728D8D964fd00C2d0AAD81718b71311feF68a) |
| Polygon | CRV       | [0x172370d5Cd63279eFa6d502DAB29171933a610AF](https://polygonscan.com/address/0x172370d5Cd63279eFa6d502DAB29171933a610AF) |
| Polygon | FXS       | [0x1a3acf6D19267E2d3e7f898f42803e90C9219062](https://polygonscan.com/address/0x1a3acf6D19267E2d3e7f898f42803e90C9219062) |
| Polygon | NEXO      | [0x41b3966B4FF7b427969ddf5da3627d6AEAE9a48E](https://polygonscan.com/address/0x41b3966B4FF7b427969ddf5da3627d6AEAE9a48E) |
| Polygon | WOO       | [0x1B815d120B3eF02039Ee11dC2d33DE7aA4a8C603](https://polygonscan.com/address/0x1B815d120B3eF02039Ee11dC2d33DE7aA4a8C603) |
| Polygon | ONEINCH   | [0x9c2C5fd7b07E95EE044DDeba0E97a665F142394f](https://polygonscan.com/address/0x9c2C5fd7b07E95EE044DDeba0E97a665F142394f) |
| Polygon | BAT       | [0x3Cef98bb43d732E2F285eE605a8158cDE967D219](https://polygonscan.com/address/0x3Cef98bb43d732E2F285eE605a8158cDE967D219) |
| Polygon | ENJ       | [0x7eC26842F195c852Fa843bB9f6D8B583a274a157](https://polygonscan.com/address/0x7eC26842F195c852Fa843bB9f6D8B583a274a157) |
| Polygon | LRC       | [0x84e1670F61347CDaeD56dcc736FB990fBB47ddC1](https://polygonscan.com/address/0x84e1670F61347CDaeD56dcc736FB990fBB47ddC1) |
| Polygon | RPL       | [0x7205705771547cF79201111B4bd8aaF29467b9eC](https://polygonscan.com/address/0x7205705771547cF79201111B4bd8aaF29467b9eC) |
| Polygon | HOT       | [0x0C51f415cF478f8D08c246a6C6Ee180C5dC3A012](https://polygonscan.com/address/0x0C51f415cF478f8D08c246a6C6Ee180C5dC3A012) |
| Polygon | POLY      | [0xcB059C5573646047D6d88dDdb87B745C18161d3b](https://polygonscan.com/address/0xcB059C5573646047D6d88dDdb87B745C18161d3b) |
| Polygon | SXP       | [0x6aBB753C1893194DE4a83c6e8B4EadFc105Fd5f5](https://polygonscan.com/address/0x6aBB753C1893194DE4a83c6e8B4EadFc105Fd5f5) |
| Polygon | COMP      | [0x8505b9d2254A7Ae468c0E9dd10Ccea3A837aef5c](https://polygonscan.com/address/0x8505b9d2254A7Ae468c0E9dd10Ccea3A837aef5c) |
| Polygon | GNO       | [0x5FFD62D3C3eE2E81C00A7b9079FB248e7dF024A8](https://polygonscan.com/address/0x5FFD62D3C3eE2E81C00A7b9079FB248e7dF024A8) |
| Polygon | IOTX      | [0xf6372cDb9c1d3674E83842e3800F2A62aC9F3C66](https://polygonscan.com/address/0xf6372cDb9c1d3674E83842e3800F2A62aC9F3C66) |
| Polygon | CEL       | [0xD85d1e945766Fea5Eda9103F918Bd915FbCa63E6](https://polygonscan.com/address/0xD85d1e945766Fea5Eda9103F918Bd915FbCa63E6) |
| Polygon | BAL       | [0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3](https://polygonscan.com/address/0x9a71012B13CA4d3D0Cdc72A177DF3ef03b0E76A3) |
| Polygon | SUSHI     | [0x0b3F868E0BE5597D5DB7fEB59E1CADBb0fdDa50a](https://polygonscan.com/address/0x0b3F868E0BE5597D5DB7fEB59E1CADBb0fdDa50a) |
| Polygon | UST       | [0x692597b009d13C4049a947CAB2239b7d6517875F](https://polygonscan.com/address/0x692597b009d13C4049a947CAB2239b7d6517875F) |
</details>
<details>
  <summary>

### Avalanche
  </summary>

| Network | Token | Address |
| ---------- | -------- | ------------------------------------------------------- |
| Avalanche | USDTe     | [0xc7198437980c041c805A1EDcbA50c1Ce5db95118](https://snowtrace.io/address/0xc7198437980c041c805A1EDcbA50c1Ce5db95118) |
| Avalanche | USDt      | [0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7](https://snowtrace.io/address/0x9702230A8Ea53601f5cD2dc00fDBc13d4dF4A8c7) |
| Avalanche | USDCe     | [0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664](https://snowtrace.io/address/0xA7D7079b0FEaD91F3e65f86E8915Cb59c1a4C664) |
| Avalanche | USDC      | [0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E](https://snowtrace.io/address/0xB97EF9Ef8734C71904D8002F8b6Bc66Dd9c48a6E) |
| Avalanche | BUSDe     | [0x19860CCB0A68fd4213aB9D8266F7bBf05A8dDe98](https://snowtrace.io/address/0x19860CCB0A68fd4213aB9D8266F7bBf05A8dDe98) |
| Avalanche | BUSD      | [0x9C9e5fD8bbc25984B178FdCE6117Defa39d2db39](https://snowtrace.io/address/0x9C9e5fD8bbc25984B178FdCE6117Defa39d2db39) |
| Avalanche | DAIe      | [0xd586E7F844cEa2F87f50152665BCbc2C279D8d70](https://snowtrace.io/address/0xd586E7F844cEa2F87f50152665BCbc2C279D8d70) |
| Avalanche | SHIBe     | [0x02D980A0D7AF3fb7Cf7Df8cB35d9eDBCF355f665](https://snowtrace.io/address/0x02D980A0D7AF3fb7Cf7Df8cB35d9eDBCF355f665) |
| Avalanche | UNIe      | [0x8eBAf22B6F053dFFeaf46f4Dd9eFA95D89ba8580](https://snowtrace.io/address/0x8eBAf22B6F053dFFeaf46f4Dd9eFA95D89ba8580) |
| Avalanche | WAVAX     | [0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7](https://snowtrace.io/address/0xB31f66AA3C1e785363F0875A1B74E27b85FD66c7) |
| Avalanche | WBTCe     | [0x50b7545627a5162F82A992c33b87aDc75187B218](https://snowtrace.io/address/0x50b7545627a5162F82A992c33b87aDc75187B218) |
| Avalanche | LINKe     | [0x5947BB275c521040051D82396192181b413227A3](https://snowtrace.io/address/0x5947BB275c521040051D82396192181b413227A3) |
| Avalanche | FRAX      | [0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64](https://snowtrace.io/address/0xD24C2Ad096400B6FBcd2ad8B24E7acBc21A1da64) |
| Avalanche | AAVEe     | [0x63a72806098Bd3D9520cC43356dD78afe5D386D9](https://snowtrace.io/address/0x63a72806098Bd3D9520cC43356dD78afe5D386D9) |
| Avalanche | TUSD      | [0x1C20E891Bab6b1727d14Da358FAe2984Ed9B59EB](https://snowtrace.io/address/0x1C20E891Bab6b1727d14Da358FAe2984Ed9B59EB) |
| Avalanche | USDD      | [0xcf799767d366d789e8B446981C2D578E241fa25c](https://snowtrace.io/address/0xcf799767d366d789e8B446981C2D578E241fa25c) |
| Avalanche | SNXe      | [0xBeC243C995409E6520D7C41E404da5dEba4b209B](https://snowtrace.io/address/0xBeC243C995409E6520D7C41E404da5dEba4b209B) |
| Avalanche | GRTe      | [0x8a0cAc13c7da965a312f08ea4229c37869e85cB9](https://snowtrace.io/address/0x8a0cAc13c7da965a312f08ea4229c37869e85cB9) |
| Avalanche | MKRe      | [0x88128fd4b259552A9A1D457f435a6527AAb72d42](https://snowtrace.io/address/0x88128fd4b259552A9A1D457f435a6527AAb72d42) |
| Avalanche | CRVe      | [0x249848BeCA43aC405b8102Ec90Dd5F22CA513c06](https://snowtrace.io/address/0x249848BeCA43aC405b8102Ec90Dd5F22CA513c06) |
| Avalanche | FXS       | [0x214DB107654fF987AD859F34125307783fC8e387](https://snowtrace.io/address/0x214DB107654fF987AD859F34125307783fC8e387) |
| Avalanche | ONEINCHe  | [0xd501281565bf7789224523144Fe5D98e8B28f267](https://snowtrace.io/address/0xd501281565bf7789224523144Fe5D98e8B28f267) |
| Avalanche | BATe      | [0x98443B96EA4b0858FDF3219Cd13e98C7A4690588](https://snowtrace.io/address/0x98443B96EA4b0858FDF3219Cd13e98C7A4690588) |
| Avalanche | SUSHIe    | [0x37B608519F91f70F2EeB0e5Ed9AF4061722e4F76](https://snowtrace.io/address/0x37B608519F91f70F2EeB0e5Ed9AF4061722e4F76) |
| Avalanche | COMPe     | [0xc3048E19E76CB9a3Aa9d77D8C03c29Fc906e2437](https://snowtrace.io/address/0xc3048E19E76CB9a3Aa9d77D8C03c29Fc906e2437) |
| Avalanche | YFIe      | [0x9eAaC1B23d935365bD7b542Fe22cEEe2922f52dc](https://snowtrace.io/address/0x9eAaC1B23d935365bD7b542Fe22cEEe2922f52dc) |
| Avalanche | ZRXe      | [0x596fA47043f99A4e0F122243B841E55375cdE0d2](https://snowtrace.io/address/0x596fA47043f99A4e0F122243B841E55375cdE0d2) |
| Avalanche | UMAe      | [0x3Bd2B1c7ED8D396dbb98DED3aEbb41350a5b2339](https://snowtrace.io/address/0x3Bd2B1c7ED8D396dbb98DED3aEbb41350a5b2339) |
| Avalanche | ANY       | [0xB44a9B6905aF7c801311e8F4E76932ee959c663C](https://snowtrace.io/address/0xB44a9B6905aF7c801311e8F4E76932ee959c663C) |
| Avalanche | KNC       | [0x39fC9e94Caeacb435842FADeDeCB783589F50f5f](https://snowtrace.io/address/0x39fC9e94Caeacb435842FADeDeCB783589F50f5f) |
| Avalanche | BTCb      | [0x152b9d0FdC40C096757F570A51E494bd4b943E50](https://snowtrace.io/address/0x152b9d0FdC40C096757F570A51E494bd4b943E50) |
| Avalanche | ORBS      | [0x340fE1D898ECCAad394e2ba0fC1F93d27c7b717A](https://snowtrace.io/address/0x340fE1D898ECCAad394e2ba0fC1F93d27c7b717A) |
| Avalanche | SYN       | [0x1f1E7c893855525b303f99bDF5c3c05Be09ca251](https://snowtrace.io/address/0x1f1E7c893855525b303f99bDF5c3c05Be09ca251) |
| Avalanche | SPELL     | [0xCE1bFFBD5374Dac86a2893119683F4911a2F7814](https://snowtrace.io/address/0xCE1bFFBD5374Dac86a2893119683F4911a2F7814) |
| Avalanche | ALPHAe    | [0x2147EFFF675e4A4eE1C2f918d181cDBd7a8E208f](https://snowtrace.io/address/0x2147EFFF675e4A4eE1C2f918d181cDBd7a8E208f) |
| Avalanche | BOBA      | [0x3cD790449CF7D187a143d4Bd7F4654d4f2403e02](https://snowtrace.io/address/0x3cD790449CF7D187a143d4Bd7F4654d4f2403e02) |
| Avalanche | SURE      | [0x5fC17416925789E0852FBFcd81c490ca4abc51F9](https://snowtrace.io/address/0x5fC17416925789E0852FBFcd81c490ca4abc51F9) |
| Avalanche | STG       | [0x2F6F07CDcf3588944Bf4C42aC74ff24bF56e7590](https://snowtrace.io/address/0x2F6F07CDcf3588944Bf4C42aC74ff24bF56e7590) |
| Avalanche | xJOE      | [0x57319d41F71E81F3c65F2a47CA4e001EbAFd4F33](https://snowtrace.io/address/0x57319d41F71E81F3c65F2a47CA4e001EbAFd4F33) |
| Avalanche | JOE       | [0x6e84a6216eA6dACC71eE8E6b0a5B7322EEbC0fDd](https://snowtrace.io/address/0x6e84a6216eA6dACC71eE8E6b0a5B7322EEbC0fDd) |
| Avalanche | BIFI      | [0xd6070ae98b8069de6B494332d1A1a81B6179D960](https://snowtrace.io/address/0xd6070ae98b8069de6B494332d1A1a81B6179D960) |
| Avalanche | ETHM      | [0x55b1a124c04A54eeFDEFE5FA2Ef5f852FB5f2f26](https://snowtrace.io/address/0x55b1a124c04A54eeFDEFE5FA2Ef5f852FB5f2f26) |
| Avalanche | QI        | [0x8729438EB15e2C8B576fCc6AeCdA6A148776C0F5](https://snowtrace.io/address/0x8729438EB15e2C8B576fCc6AeCdA6A148776C0F5) |
| Avalanche | SWAPe     | [0xc7B5D72C836e718cDA8888eaf03707fAef675079](https://snowtrace.io/address/0xc7B5D72C836e718cDA8888eaf03707fAef675079) |
| Avalanche | UNCX      | [0x3b9e3b5c616A1A038fDc190758Bbe9BAB6C7A857](https://snowtrace.io/address/0x3b9e3b5c616A1A038fDc190758Bbe9BAB6C7A857) |
| Avalanche | WALBT     | [0x9E037dE681CaFA6E661e6108eD9c2bd1AA567Ecd](https://snowtrace.io/address/0x9E037dE681CaFA6E661e6108eD9c2bd1AA567Ecd) |
| Avalanche | JADE      | [0x80B010450fDAf6a3f8dF033Ee296E92751D603B3](https://snowtrace.io/address/0x80B010450fDAf6a3f8dF033Ee296E92751D603B3) |
| Avalanche | sJADE     | [0x3D9eAB723df76808bB84c05b20De27A2e69EF293](https://snowtrace.io/address/0x3D9eAB723df76808bB84c05b20De27A2e69EF293) |
| Avalanche | RISE      | [0xC17c30e98541188614dF99239cABD40280810cA3](https://snowtrace.io/address/0xC17c30e98541188614dF99239cABD40280810cA3) |
| Avalanche | PENDLE    | [0xfB98B335551a418cD0737375a2ea0ded62Ea213b](https://snowtrace.io/address/0xfB98B335551a418cD0737375a2ea0ded62Ea213b) |
</details>
<details>
  <summary>

### Fantom
  </summary>

| Network | Token | Address |
| ---------- | -------- | ------------------------------------------------------- |
| Fantom | FBTC      | [0xe1146b9AC456fCbB60644c36Fd3F868A9072fc6E](https://ftmscan.com/address/0xe1146b9AC456fCbB60644c36Fd3F868A9072fc6E) |
| Fantom | FETH      | [0x658b0c7613e890EE50B8C4BC6A3f41ef411208aD](https://ftmscan.com/address/0x658b0c7613e890EE50B8C4BC6A3f41ef411208aD) |
| Fantom | USDC      | [0x04068DA6C83AFCFA0e13ba15A6696662335D5B75](https://ftmscan.com/address/0x04068DA6C83AFCFA0e13ba15A6696662335D5B75) |
| Fantom | DAI       | [0x8D11eC38a3EB5E956B052f67Da8Bdc9bef8Abf3E](https://ftmscan.com/address/0x8D11eC38a3EB5E956B052f67Da8Bdc9bef8Abf3E) |
| Fantom | AVAX      | [0x511D35c52a3C244E7b8bd92c0C297755FbD89212](https://ftmscan.com/address/0x511D35c52a3C244E7b8bd92c0C297755FbD89212) |
| Fantom | BTC       | [0x321162Cd933E2Be498Cd2267a90534A804051b11](https://ftmscan.com/address/0x321162Cd933E2Be498Cd2267a90534A804051b11) |
| Fantom | LINK      | [0xb3654dc3D10Ea7645f8319668E8F54d2574FBdC8](https://ftmscan.com/address/0xb3654dc3D10Ea7645f8319668E8F54d2574FBdC8) |
| Fantom | FRAX      | [0xdc301622e621166BD8E82f2cA0A26c13Ad0BE355](https://ftmscan.com/address/0xdc301622e621166BD8E82f2cA0A26c13Ad0BE355) |
| Fantom | AAVE      | [0x6a07A792ab2965C72a5B8088d3a069A7aC3a993B](https://ftmscan.com/address/0x6a07A792ab2965C72a5B8088d3a069A7aC3a993B) |
| Fantom | TUSD      | [0x9879aBDea01a879644185341F7aF7d8343556B7a](https://ftmscan.com/address/0x9879aBDea01a879644185341F7aF7d8343556B7a) |
| Fantom | USDD      | [0xcf799767d366d789e8B446981C2D578E241fa25c](https://ftmscan.com/address/0xcf799767d366d789e8B446981C2D578E241fa25c) |
| Fantom | SFTM      | [0x69c744D3444202d35a2783929a0F930f2FBB05ad](https://ftmscan.com/address/0x69c744D3444202d35a2783929a0F930f2FBB05ad) |
| Fantom | WFTM      | [0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83](https://ftmscan.com/address/0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83) |
| Fantom | SNX       | [0x56ee926bD8c72B2d5fa1aF4d9E4Cbb515a1E3Adc](https://ftmscan.com/address/0x56ee926bD8c72B2d5fa1aF4d9E4Cbb515a1E3Adc) |
| Fantom | CRV       | [0x1E4F97b9f9F913c46F1632781732927B9019C68b](https://ftmscan.com/address/0x1E4F97b9f9F913c46F1632781732927B9019C68b) |
| Fantom | FXS       | [0x7d016eec9c25232b01F23EF992D98ca97fc2AF5a](https://ftmscan.com/address/0x7d016eec9c25232b01F23EF992D98ca97fc2AF5a) |
| Fantom | CEL       | [0x2C78f1b70Ccf63CDEe49F9233e9fAa99D43AA07e](https://ftmscan.com/address/0x2C78f1b70Ccf63CDEe49F9233e9fAa99D43AA07e) |
| Fantom | SUSHI     | [0xae75A438b2E0cB8Bb01Ec1E1e376De11D44477CC](https://ftmscan.com/address/0xae75A438b2E0cB8Bb01Ec1E1e376De11D44477CC) |
| Fantom | BAND      | [0x46E7628E8b4350b2716ab470eE0bA1fa9e76c6C5](https://ftmscan.com/address/0x46E7628E8b4350b2716ab470eE0bA1fa9e76c6C5) |
| Fantom | FBAND     | [0x078EEF5A2fb533e1a4d487ef64b27DF113d12C32](https://ftmscan.com/address/0x078EEF5A2fb533e1a4d487ef64b27DF113d12C32) |
| Fantom | YFI       | [0x29b0Da86e484E1C0029B56e817912d778aC0EC69](https://ftmscan.com/address/0x29b0Da86e484E1C0029B56e817912d778aC0EC69) |
| Fantom | SYN       | [0xE55e19Fb4F2D85af758950957714292DAC1e25B2](https://ftmscan.com/address/0xE55e19Fb4F2D85af758950957714292DAC1e25B2) |
| Fantom | MIM       | [0x82f0B8B456c1A451378467398982d4834b6829c1](https://ftmscan.com/address/0x82f0B8B456c1A451378467398982d4834b6829c1) |
| Fantom | ORBS      | [0x3E01B7E242D5AF8064cB9A8F9468aC0f8683617c](https://ftmscan.com/address/0x3E01B7E242D5AF8064cB9A8F9468aC0f8683617c) |
| Fantom | SPELL     | [0x468003B688943977e6130F4F68F23aad939a1040](https://ftmscan.com/address/0x468003B688943977e6130F4F68F23aad939a1040) |
| Fantom | ALPHA     | [0x11eb3aA66FE1f2B75cB353D3e874E96968182BdA](https://ftmscan.com/address/0x11eb3aA66FE1f2B75cB353D3e874E96968182BdA) |
| Fantom | BOBA      | [0x4389b230D15119c347B9E8BEA6d930A21aaDF6BA](https://ftmscan.com/address/0x4389b230D15119c347B9E8BEA6d930A21aaDF6BA) |
| Fantom | STG       | [0x2F6F07CDcf3588944Bf4C42aC74ff24bF56e7590](https://ftmscan.com/address/0x2F6F07CDcf3588944Bf4C42aC74ff24bF56e7590) |
| Fantom | ALPACA    | [0xaD996A45fd2373ed0B10Efa4A8eCB9de445A4302](https://ftmscan.com/address/0xaD996A45fd2373ed0B10Efa4A8eCB9de445A4302) |
| Fantom | KP3R      | [0x2A5062D22adCFaAfbd5C541d4dA82E4B450d4212](https://ftmscan.com/address/0x2A5062D22adCFaAfbd5C541d4dA82E4B450d4212) |
| Fantom | ORN       | [0xD2cDcB6BdEE6f78DE7988a6A60d13F6eF0b576D9](https://ftmscan.com/address/0xD2cDcB6BdEE6f78DE7988a6A60d13F6eF0b576D9) |
| Fantom | HEGIC     | [0x44B26E839eB3572c5E959F994804A5De66600349](https://ftmscan.com/address/0x44B26E839eB3572c5E959F994804A5De66600349) |
| Fantom | DOLA      | [0x3129662808bEC728a27Ab6a6b9AFd3cBacA8A43c](https://ftmscan.com/address/0x3129662808bEC728a27Ab6a6b9AFd3cBacA8A43c) |
| Fantom | TOR       | [0x74E23dF9110Aa9eA0b6ff2fAEE01e740CA1c642e](https://ftmscan.com/address/0x74E23dF9110Aa9eA0b6ff2fAEE01e740CA1c642e) |
| Fantom | BOO       | [0x841FAD6EAe12c286d1Fd18d1d525DFfA75C7EFFE](https://ftmscan.com/address/0x841FAD6EAe12c286d1Fd18d1d525DFfA75C7EFFE) |
| Fantom | RISE      | [0xC17c30e98541188614dF99239cABD40280810cA3](https://ftmscan.com/address/0xC17c30e98541188614dF99239cABD40280810cA3) |
| Fantom | RAI       | [0xa71353Bb71DdA105D383B02fc2dD172C4D39eF8B](https://ftmscan.com/address/0xa71353Bb71DdA105D383B02fc2dD172C4D39eF8B) |
| Fantom | HOGE      | [0xF31778D591c558140398F46feCA42A6a2dbFFe90](https://ftmscan.com/address/0xF31778D591c558140398F46feCA42A6a2dbFFe90) |
| Fantom | GEL       | [0x15b7c0c907e4C6b9AdaAaabC300C08991D6CEA05](https://ftmscan.com/address/0x15b7c0c907e4C6b9AdaAaabC300C08991D6CEA05) |
| Fantom | GEIST     | [0xd8321AA83Fb0a4ECd6348D4577431310A6E0814d](https://ftmscan.com/address/0xd8321AA83Fb0a4ECd6348D4577431310A6E0814d) |
| Fantom | wBAN      | [0xe20B9e246db5a0d21BF9209E4858Bc9A3ff7A034](https://ftmscan.com/address/0xe20B9e246db5a0d21BF9209E4858Bc9A3ff7A034) |
| Fantom | HEC       | [0x5C4FDfc5233f935f20D2aDbA572F770c2E377Ab0](https://ftmscan.com/address/0x5C4FDfc5233f935f20D2aDbA572F770c2E377Ab0) |
| Fantom | sHEC      | [0x75bdeF24285013387A47775828bEC90b91Ca9a5F](https://ftmscan.com/address/0x75bdeF24285013387A47775828bEC90b91Ca9a5F) |
| Fantom | TOMB      | [0x6c021Ae822BEa943b2E66552bDe1D2696a53fbB7](https://ftmscan.com/address/0x6c021Ae822BEa943b2E66552bDe1D2696a53fbB7) |
| Fantom | fmXEN     | [0xeF4B763385838FfFc708000f884026B8c0434275](https://ftmscan.com/address/0xeF4B763385838FfFc708000f884026B8c0434275) |
| Fantom | TREEB     | [0xc60D7067dfBc6f2caf30523a064f416A5Af52963](https://ftmscan.com/address/0xc60D7067dfBc6f2caf30523a064f416A5Af52963) |
| Fantom | BEETS     | [0xF24Bcf4d1e507740041C9cFd2DddB29585aDCe1e](https://ftmscan.com/address/0xF24Bcf4d1e507740041C9cFd2DddB29585aDCe1e) |
| Fantom | WIGO      | [0xE992bEAb6659BFF447893641A378FbbF031C5bD6](https://ftmscan.com/address/0xE992bEAb6659BFF447893641A378FbbF031C5bD6) |
| Fantom | TETU      | [0x65c9d9d080714cDa7b5d58989Dc27f897F165179](https://ftmscan.com/address/0x65c9d9d080714cDa7b5d58989Dc27f897F165179) |
| Fantom | TSHARE    | [0x4cdF39285D7Ca8eB3f090fDA0C069ba5F4145B37](https://ftmscan.com/address/0x4cdF39285D7Ca8eB3f090fDA0C069ba5F4145B37) |
</details>
<details>
  <summary>

### Optimism
  </summary>

| Network | Token | Address |
| ---------- | -------- | ------------------------------------------------------- |
| Optimism | USDT      | [0x94b008aA00579c1307B0EF2c499aD98a8ce58e58](https://optimistic.etherscan.io/address/0x94b008aA00579c1307B0EF2c499aD98a8ce58e58) |
| Optimism | USDC      | [0x7F5c764cBc14f9669B88837ca1490cCa17c31607](https://optimistic.etherscan.io/address/0x7F5c764cBc14f9669B88837ca1490cCa17c31607) |
| Optimism | DAI       | [0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1](https://optimistic.etherscan.io/address/0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1) |
| Optimism | WBTC      | [0x68f180fcCe6836688e9084f035309E29Bf0A2095](https://optimistic.etherscan.io/address/0x68f180fcCe6836688e9084f035309E29Bf0A2095) |
| Optimism | LINK      | [0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6](https://optimistic.etherscan.io/address/0x350a791Bfc2C21F9Ed5d10980Dad2e2638ffa7f6) |
| Optimism | LDO       | [0xFdb794692724153d1488CcdBE0C56c252596735F](https://optimistic.etherscan.io/address/0xFdb794692724153d1488CcdBE0C56c252596735F) |
| Optimism | FRAX      | [0x2E3D870790dC77A83DD1d18184Acc7439A53f475](https://optimistic.etherscan.io/address/0x2E3D870790dC77A83DD1d18184Acc7439A53f475) |
| Optimism | USDD      | [0xC22885e06cd8507c5c74a948C59af853AEd1Ea5C](https://optimistic.etherscan.io/address/0xC22885e06cd8507c5c74a948C59af853AEd1Ea5C) |
| Optimism | SNX       | [0x8700dAec35aF8Ff88c16BdF0418774CB3D7599B4](https://optimistic.etherscan.io/address/0x8700dAec35aF8Ff88c16BdF0418774CB3D7599B4) |
| Optimism | FXS       | [0x67CCEA5bb16181E7b4109c9c2143c24a1c2205Be](https://optimistic.etherscan.io/address/0x67CCEA5bb16181E7b4109c9c2143c24a1c2205Be) |
| Optimism | OP        | [0x4200000000000000000000000000000000000042](https://optimistic.etherscan.io/address/0x4200000000000000000000000000000000000042) |
| Optimism | UST       | [0xFB21B70922B9f6e3C6274BcD6CB1aa8A0fe20B80](https://optimistic.etherscan.io/address/0xFB21B70922B9f6e3C6274BcD6CB1aa8A0fe20B80) |
| Optimism | KNC       | [0xa00E3A3511aAC35cA78530c85007AFCd31753819](https://optimistic.etherscan.io/address/0xa00E3A3511aAC35cA78530c85007AFCd31753819) |
| Optimism | sUSD      | [0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9](https://optimistic.etherscan.io/address/0x8c6f28f2F1A3C87F0f938b96d27520d9751ec8d9) |
| Optimism | BIFI      | [0x4E720DD3Ac5CFe1e1fbDE4935f386Bb1C66F4642](https://optimistic.etherscan.io/address/0x4E720DD3Ac5CFe1e1fbDE4935f386Bb1C66F4642) |
| Optimism | sETH      | [0xE405de8F52ba7559f9df3C368500B6E6ae6Cee49](https://optimistic.etherscan.io/address/0xE405de8F52ba7559f9df3C368500B6E6ae6Cee49) |
| Optimism | BOB       | [0xB0B195aEFA3650A6908f15CdaC7D92F8a5791B0B](https://optimistic.etherscan.io/address/0xB0B195aEFA3650A6908f15CdaC7D92F8a5791B0B) |
| Optimism | THALES    | [0x217D47011b23BB961eB6D93cA9945B7501a5BB11](https://optimistic.etherscan.io/address/0x217D47011b23BB961eB6D93cA9945B7501a5BB11) |
| Optimism | USDPLUS   | [0x73cb180bf0521828d8849bc8CF2B920918e23032](https://optimistic.etherscan.io/address/0x73cb180bf0521828d8849bc8CF2B920918e23032) |
| Optimism | sBTC      | [0x298B9B95708152ff6968aafd889c6586e9169f1D](https://optimistic.etherscan.io/address/0x298B9B95708152ff6968aafd889c6586e9169f1D) |
| Optimism | RGT       | [0xB548f63D4405466B36C0c0aC3318a22fDcec711a](https://optimistic.etherscan.io/address/0xB548f63D4405466B36C0c0aC3318a22fDcec711a) |
| Optimism | HOP       | [0xc5102fE9359FD9a28f877a67E36B0F050d81a3CC](https://optimistic.etherscan.io/address/0xc5102fE9359FD9a28f877a67E36B0F050d81a3CC) |
| Optimism | O3        | [0xEe9801669C6138E84bD50dEB500827b776777d28](https://optimistic.etherscan.io/address/0xEe9801669C6138E84bD50dEB500827b776777d28) |
| Optimism | DCN       | [0x1da650C3B2DaA8AA9Ff6F661d4156Ce24d08A062](https://optimistic.etherscan.io/address/0x1da650C3B2DaA8AA9Ff6F661d4156Ce24d08A062) |
| Optimism | sLINK     | [0xc5Db22719A06418028A40A9B5E9A7c02959D0d08](https://optimistic.etherscan.io/address/0xc5Db22719A06418028A40A9B5E9A7c02959D0d08) |
| Optimism | PICKLE    | [0x0c5b4c92c948691EEBf185C17eeB9c230DC019E9](https://optimistic.etherscan.io/address/0x0c5b4c92c948691EEBf185C17eeB9c230DC019E9) |
| Optimism | ROOBEE    | [0xb12c13e66AdE1F72f71834f2FC5082Db8C091358](https://optimistic.etherscan.io/address/0xb12c13e66AdE1F72f71834f2FC5082Db8C091358) |
| Optimism | GRG       | [0xEcF46257ed31c329F204Eb43E254C609dee143B3](https://optimistic.etherscan.io/address/0xEcF46257ed31c329F204Eb43E254C609dee143B3) |
| Optimism | IB        | [0x00a35FD824c717879BF370E70AC6868b95870Dfb](https://optimistic.etherscan.io/address/0x00a35FD824c717879BF370E70AC6868b95870Dfb) |
</details>

## Usage

The following attack contract demonstrates a simple token balance manipulation of USDC on a fork of Ethereum mainnet.

* [TokenExampleManipulation](./examples/TokenExampleManipulation.sol)

Extend the Tokens contract to set an accounts balance for the specified token or to transfer tokens from one address to another:
```
// Modify the account balance for the specified token
deal(EthereumTokens.USDC, address(this), 1 ether);

// Impersonate the address 'user' with a prank call and transfer tokens from 'user' to 'address(this)' using the token's IERC20 interface
dealFrom(EthereumTokens.USDC, user, address(this), 1 ether);
```
