import { loadFixture, ethers, expect } from "./setup";

describe("ERC721", function () {
  async function deploy() {
    const [owner, user1, user2, user3] = await ethers.getSigners();
    const shefTokenFactory = await ethers.getContractFactory("MyToken", owner);
    const shefToken = await shefTokenFactory.deploy();
    await shefToken.waitForDeployment()
    return { owner, user1, user2, user3, shefToken }
  }

  describe("Deployment", function () {
    it("Should set the correct name and symbol", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      expect(await shefToken.name()).to.equal("shefToken");
      expect(await shefToken.symbol()).to.equal("shef");
    });
  });

  describe("Minting", function () {
    it("Should mint a new token and assign it to the correct owner", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      await shefToken.safeMint(await owner.getAddress(), 1);
      expect(await shefToken.ownerOf(1)).to.equal(await owner.getAddress());
    });

    it("Should not allow minting a token with the same ID", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      await shefToken.safeMint(await owner.getAddress(), 1);
      await expect(shefToken.safeMint(await owner.getAddress(), 1)).to.be.revertedWith("Already exists");
    });
  });

  describe("Transfers", function () {
    it("Should transfer a token from one owner to another", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      await shefToken.safeMint(await owner.getAddress(), 1);
      await shefToken.transferFrom(await owner.getAddress(), await user1.getAddress(), 1);
      expect(await shefToken.ownerOf(1)).to.equal(await user1.getAddress());
    });

    it("Should not allow transfer from a non-owner", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      await shefToken.safeMint(await owner.getAddress(), 1);
      await expect(shefToken.transferFrom(await user1.getAddress(), await user2.getAddress(), 1)).to.be.revertedWith("Not an owner!");
    });
  });

  describe("Approvals", function () {
    it("Should allow an owner to approve another address", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      await shefToken.safeMint(await owner.getAddress(), 1);
      await shefToken.approve(await user1.getAddress(), 1);
      expect(await shefToken.getApproved(1)).to.equal(await user1.getAddress());
    });

    it("Should allow approved address to transfer the token", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      await shefToken.safeMint(await owner.getAddress(), 1);
      await shefToken.approve(await user1.getAddress(), 1);
      await shefToken.connect(user1).transferFrom(await owner.getAddress(), await user2.getAddress(), 1);
      expect(await shefToken.ownerOf(1)).to.equal(await user2.getAddress());
    });
  });

  describe("Burning", function () {
    it("Should burn a token", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      await shefToken.safeMint(await owner.getAddress(), 1);
      await shefToken.burn(1);
      await expect(shefToken.ownerOf(1)).to.be.revertedWith("Not minted");
    });

    it("Should not allow non-owner to burn a token", async function () {
      const { owner, user1, user2, user3, shefToken } = await loadFixture(deploy);
      await shefToken.safeMint(await owner.getAddress(), 1);
      await expect(shefToken.connect(user1).burn(1)).to.be.revertedWith("Not an owner or approved!");
    });
  });
  
})