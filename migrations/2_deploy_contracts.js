var DominantAssuranceContract = artifacts.require("./DominantAssuranceContract.sol");

module.exports = function(deployer) {
    deployer.deploy(DominantAssuranceContract, 10, 30, 110, 100);
};
