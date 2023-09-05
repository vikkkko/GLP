import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import * as env from "dotenv";
import '@openzeppelin/hardhat-upgrades';

env.config({ path: './.env' });

const accounts = {
  mnemonic:
    process.env.MNEMONIC
    // "test test test test test test test test test test test junk",
};

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.18",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  defaultNetwork: 'polygon',
  networks: {
    goerli: {
      url: `https://goerli.infura.io/v3/638c755c81fe495e85debe581520b373`,
      accounts
    },
    polygon: {
      url: `https://polygon-rpc.com`,
      accounts
    },
  }
};

export default config;
