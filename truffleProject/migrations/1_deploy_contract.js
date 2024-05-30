const Auth_Contract = artifacts.require("AuthContract");

module.exports = function(deployer) {
  deployer.deploy(Auth_Contract);
};