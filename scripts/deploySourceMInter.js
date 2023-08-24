async function main() {
    const router = "0xD0daae2231E9CB96b94C8512223533293C3693Bf";
    const linkAddress  = "0x779877A7B0D9E8603169DdbD7836e478b4624789";
    const srcMinter = await hre.ethers.deployContract("MyNft", router, linkAddress);
  
    await srcMinter.waitForDeployment();
  
    console.log(
      `Minter contract deployed to ${srcMinter.target}`
    );
  }
  
  // We recommend this pattern to be able to use async/await everywhere
  // and properly handle errors.
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });