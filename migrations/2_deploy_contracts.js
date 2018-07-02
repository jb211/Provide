var DominantAssuranceContract = artifacts.require("./DominantAssuranceContract.sol");

module.exports = function(deployer) {
    deployer.deploy(DominantAssuranceContract, 1, 30, 110);
};
