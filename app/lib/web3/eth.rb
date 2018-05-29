require "lib/web3/eth/contract"

module Web3
  module Eth
    def self.contract(abi)
      Contract.new(`web3.eth.contract(#{abi.to_n})`)
    end

    def self.accounts
      `web3.eth.accounts`
    end
  end
end
