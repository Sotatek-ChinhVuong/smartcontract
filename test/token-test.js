const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Token", function () {
  it("name shold be 'Happee bug' and symbol is 'HBUG'.", async function () {
    const Token = await ethers.getContractFactory("Token");
    const token = await Token.deploy();
    await token.deployed();

    expect(await token.name()).to.equal("Happee bug");

    // // wait until the transaction is mined
    // await setGreetingTx.wait();

    expect(await token.symbol()).to.equal("HBUG");
  });
});

