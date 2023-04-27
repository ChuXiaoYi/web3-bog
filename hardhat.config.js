require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  networks: {
    hardhat: {
      // chainId: 1337,
    },
    // sepolia: {
    //   url: "https://rpc.sepolia.io",
    //   accounts: ["0x" + process.env.SEPOLIA_PRIVATE_KEY],
    // },
  },
};
