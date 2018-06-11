require "lib/web3/eth"

module Web3
  def self.from_wei(big_number)
    `web3.fromWei(#{big_number})`
  end

  def self.to_wei(big_number)
    `web3.toWei(#{big_number})`
  end
end
