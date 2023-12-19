const hre = require("hardhat");

async function main() {
  const Auction = await hre.ethers.getContractFactory("Auction");
  const auction = await Auction.deploy(60); // give parameter for Constructor

  await auction.waitForDeployment();

  console.log("Deployed at : ", await auction.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

//contract address : 0xa9Bfd852a6dfecDD4c06CAD02D7425510e3A37b8
// endTime: 60
