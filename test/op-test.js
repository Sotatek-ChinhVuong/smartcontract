const { expect } = require("chai");
describe("Token contract", function () {


  let Token;
  let hardhatToken;
  let owner;
  let addr1;
  let addr2;
  let addrs;

  beforeEach(async function () {
    Token = await ethers.getContractFactory("Token");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    hardhatToken = await Token.deploy();
  });

  describe("Deployment", function () {
   
    it("Should set the right owner", async function () {
      expect(await hardhatToken.owner()).to.equal(owner.address);
    });

    it("Should assign the total supply of tokens to the owner", async function () {
      const ownerBalance = await hardhatToken.balanceOf(owner.address);
      expect(await hardhatToken.totalSupply()).to.equal(0);
    });
  });

  describe("Mint", function () {
    it("Show balances after mint", async function() {
      await hardhatToken.mint(owner.address, 500);
      expect(await hardhatToken.balanceOf(owner.address), 500)
    });
  });
});