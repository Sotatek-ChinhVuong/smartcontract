const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Token", function () {
  it("Name shold be 'Happee bug'", async function () {
    const Token = await ethers.getContractFactory("Token");
    const token = await Token.deploy();
    await token.deployed();
    expect(await token.name()).to.equal("Happee bug");
    expect(await token.symbol()).to.equal("HBUG");
  });

  it("Symbol shold be 'HBUG'", async function () {
    const Token = await ethers.getContractFactory("Token");
    const token = await Token.deploy();
    await token.deployed();
    expect(await token.symbol()).to.equal("HBUG");
  });
  
  it("Check total supply", async function () {
    const [owner] = await ethers.getSigners();
    const Token = await ethers.getContractFactory("Token");
    const hardhatToken = await Token.deploy();
    const ownerBalance = await hardhatToken.balanceOf(owner.address);
    
    expect(await hardhatToken.totalSupply()).to.equal(ownerBalance);
  });

  it("Check owner", async function () {
    const Token = await ethers.getContractFactory("Token");
    const [owner] = await ethers.getSigners();
    const hardhatToken = await Token.deploy();
    expect(await hardhatToken.owner(), owner)
  });


});

