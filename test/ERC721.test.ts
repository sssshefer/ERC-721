import { loadFixture, ethers, expect } from "./setup";

describe("ERC721", function () {
  async function deploy() {
    const [owner, user] = await ethers.getSigners();
    const erc721Factory = await ethers.getContractFactory("ERC721", owner);
    const erc721 = await erc721Factory.deploy();
    await erc721.waitForDeployment()
    return { owner,  user}
  }
})