require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");
// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});
const ALCHEMY_API_KEY = 'g8QryFcm7jFUlVZocxQJ6i0eDG4bXkfh';
// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more
const ROPSTEN_PRIVATE_KEY = 'e002ffa2c8b3e16d6d8316ff5c0dd5825c785c4e1e1bf8c258846941d7695f73'
/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.4",
  networks: {
    rinkeby: {
      url: `https://eth-rinkeby.alchemyapi.io/v2/${ALCHEMY_API_KEY}`,
      accounts: [`${ROPSTEN_PRIVATE_KEY}`]
    }
  },
  etherscan: {
    apiKey: "P24S4Z1KKPZ4TS98JWNI4I4TMFQS65MP4B"
  }
  
};
