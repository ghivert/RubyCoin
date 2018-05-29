require "lib/web3/eth/contract/instance"

module Web3
  module Eth
    class Contract
      def initialize(contract)
        @contract = contract
      end

      def at(address)
        Instance.new(`#{@contract}.at(#{address})`)
      end
    end
  end
end
