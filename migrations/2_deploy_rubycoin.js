var RubyCoin = artifacts.require("RubyCoin")

var contract

module.exports = function(deployer, network, accounts) {
  deployer.deploy(RubyCoin, 1, 0, 0).then(function(instance) {
    contract = instance
    return contract.totalSupply.call()
  }).then(function(totalSupply) {
    console.log(totalSupply)
    return contract.transfer(accounts[1], 100, {from: accounts[0]})
  }).then(function(transaction) {
    console.log(transaction)
    return contract.balanceOf.call(accounts[0])
  }).then(function(balanceOfOwner) {
    console.log(balanceOfOwner)
  }).catch(function(error) {
    console.log(error)
  })
}
