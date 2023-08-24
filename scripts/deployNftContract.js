
async function main() {
  const srcMinter = ""
  const myNft = await hre.ethers.deployContract("MyNft", srcMinter);

  await myNft.waitForDeployment();

  console.log(
    `Nft contract deployed to ${myNft.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
