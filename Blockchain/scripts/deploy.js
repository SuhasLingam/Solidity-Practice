const hre = require("hardhat");

async function main() {
  const Auction = await hre.ethers.getContractFactory("Auction");
  const auction = await Auction.deploy(60); // give parameter for Constructor

  await auction.waitForDeployment();

  console.log("Deployed at : ", await auction.getAddress());
  const chainId = await hre.ethers.provider
    .getNetwork()
    .then((network) => network.chainId);
  console.log("Chain ID: ", chainId);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

//contract address : 0x2E6e494A6C2c2703Bfdd22D2458B2bF92C435947
// endTime: 60
