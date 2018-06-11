var RubyCoin = artifacts.require("RubyCoin")

var contract

module.exports = function(deployer, network, accounts) {
  deployer.deploy(RubyCoin, "1.0.0").then(function(instance) {
    contract = instance
    return contract.transfer(accounts[1], 100, {from: accounts[0]})
  }).then(function(transaction) {
    return
  }).catch(function(error) {
    console.log(error)
  })
}
