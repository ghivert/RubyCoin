require "lib/web3/eth/contract"

module Web3
  module Eth
    def self.contract(abi)
      Contract.new(`web3.eth.contract(#{abi.to_n})`)
    end

    def self.accounts
      `web3.eth.accounts`
    end

    def self.account
      accounts[0]
    end

    def self.get_balance(account, &block)
      `web3.eth.getBalance(#{account}, function(error, result) {
        #{block.call(`error`, `result`)}
      })`
    end
  end
end
