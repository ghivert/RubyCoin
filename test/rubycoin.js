var RubyCoin = artifacts.require("RubyCoin")

contract('RubyCoin', function(accounts) {
  it("should have a total supply of 1e9", function() {
    return RubyCoin.deployed().then(function(instance) {
      return instance.totalSupply.call()
    }).then(function(supply) {
      assert.equal(supply.valueOf(), 1e9, "The total supply is not 1e9")
    })
  })

  it("should put (1e9 - 100) RubyCoin in the deployer account", function() {
    return RubyCoin.deployed().then(function(instance) {
      return instance.balanceOf.call(accounts[0])
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 1e9 - 100, "There was no 1e9 coin in the first account")
    })
  })

  it("should put 100 RubyCoin in the second account", function() {
    return RubyCoin.deployed().then(function(instance) {
      return instance.balanceOf.call(accounts[1])
    }).then(function(balance) {
      assert.equal(balance.valueOf(), 100, "There's no 100 coin in the second account")
    })
  })

  it("should send coin correctly from first account to second", function() {
    var ruby

    // Get initial balances of first and second account.
    var account_one = accounts[0]
    var account_two = accounts[1]

    var account_one_starting_balance
    var account_two_starting_balance
    var account_one_ending_balance
    var account_two_ending_balance

    var amount = 10

    return RubyCoin.deployed().then(function(instance) {
      ruby = instance
      return ruby.balanceOf.call(account_one)
    }).then(function(balance) {
      account_one_starting_balance = balance.toNumber();
      return ruby.balanceOf.call(account_two)
    }).then(function(balance) {
      account_two_starting_balance = balance.toNumber();
      return ruby.transfer(account_two, amount, {from: account_one})
    }).then(function() {
      return ruby.balanceOf.call(account_one)
    }).then(function(balance) {
      account_one_ending_balance = balance.toNumber()
      return ruby.balanceOf.call(account_two)
    }).then(function(balance) {
      account_two_ending_balance = balance.toNumber()

      assert.equal(account_one_ending_balance, account_one_starting_balance - amount, "Amount wasn't correctly taken from the sender")
      assert.equal(account_two_ending_balance, account_two_starting_balance + amount, "Amount wasn't correctly sent to the receiver")
    })
  })

  it("should approve spending and spend first account from second account", function() {
    var ruby

    var account_one = accounts[0]
    var account_two = accounts[1]

    var account_one_starting_balance
    var account_two_starting_balance
    var account_one_ending_balance
    var account_two_ending_balance

    var amount = 10

    return RubyCoin.deployed().then(function(instance) {
      ruby = instance
      return ruby.balanceOf.call(account_one)
    }).then(function(balance) {
      account_one_starting_balance = balance.toNumber();
      return ruby.balanceOf.call(account_two)
    }).then(function(balance) {
      account_two_starting_balance = balance.toNumber();
      return ruby.approve(account_two, amount, {from: account_one})
    }).then(function(success) {
      if (success) {
        return ruby.allowance.call(account_one, account_two)
      } else {
        assert.equal(success, false, "Approval should have return false")
      }
    }).then(function(remaining) {
      assert.equal(remaining.toNumber(), amount, "Approve did not worked")
      return ruby.transferFrom(account_one, account_two, amount, {from: account_two})
    }).then(function(success) {
      if (success) {
        return ruby.balanceOf.call(account_one)
      } else {
        assert.equal(success, false, "Transfer should have return false")
      }
    }).then(function(balance) {
      account_one_ending_balance = balance.toNumber()
      return ruby.balanceOf(account_two)
    }).then(function(balance) {
      account_two_ending_balance = balance.toNumber()

      assert.equal(account_one_ending_balance, account_one_starting_balance - 10, "Amount wasn't correctly taken from the sender")
      assert.equal(account_two_ending_balance, account_two_starting_balance + 10, "Amount wasn't sent to the receiver")
    })
  })
})
