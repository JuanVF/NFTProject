const { ethers } = require("hardhat");

const deploy = async () => {
  const [deployer] = await ethers.getSigners();

  console.log(`Deploying contract with the account ${deployer.address}`);

  const NFTs = await ethers.getContractFactory("NFTs");
  const deployed = await NFTs.deploy(10000);

  console.log(`NFTs Project deployed at: ${deployed.address}`);
};

deploy()
  .then(() => process.exit(0))
  .catch((err) => {
    console.log(err);
    process.exit(1);
  });
