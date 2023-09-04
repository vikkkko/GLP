const { ethers, upgrades } = require("hardhat");

const NFT_ADDRESS = "";

//mp4 :   https://ipfs.io/ipfs/bafybeidgynar2hjzdcn2e6gnnf4j3ffm7dbpxaamdnjamefhpkkhow6ta4
async function main() {
  const [owner, proxyOwner] = await ethers.getSigners();

  const nft = await ethers.getContractFactory("NFT");

  if(NFT_ADDRESS){
    //upgradge
    const n = await upgrades.upgradeProxy(NFT_ADDRESS, nft);
    console.log("upgraded");
  } else {
    //deploy
    const n = await upgrades.deployProxy(
      nft,
      [""]);
  
    await n.waitForDeployment();
    console.log("nft deployed to:", await n.getAddress());
  }
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
