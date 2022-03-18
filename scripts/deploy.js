
const hre = require("hardhat");

async function main() {

  const INITIAL_TOKEN_SUPPLY = 1000000;

  const ERC20TokenContract = await hre.ethers.getContractFactory("ERC20Token");
  const erc20Token = await ERC20TokenContract.deploy(INITIAL_TOKEN_SUPPLY);

  await erc20Token.deployed();

  const ERC721TokenContract = await hre.ethers.getContractFactory("ERC721Token");
  const erc721Token = await ERC721TokenContract.deploy();

  await erc721Token.deployed();

  console.log("ERC20TokenContract deployed to:", erc20Token.address);
  console.log("ERC721TokenContract deployed to:", erc721Token.address)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
