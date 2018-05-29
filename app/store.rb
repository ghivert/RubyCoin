class Store
  include Inesita::Injection

  attr_accessor :bitcoin_values
  attr_accessor :bitcoin_current_value
  attr_reader   :balance_of_rubycoin

  def init
    contract_interface = JSON.parse(`document.getElementsByName('contract-interface')[0].content`)
    @bitcoin_values = {}
    @bitcoin_current_value = nil
    @balance_of_rubycoin = nil
    @contract = {
      interface: contract_interface,
      instance:
        ::Web3::Eth.contract(contract_interface[:abi])
                   .at(contract_interface[:networks]["5777"][:address])
    }
    get_bitcoin_prices
    get_balance_of_rubycoin
  end

  private

  def get_bitcoin_prices
    Bitcoin.get_current_price.then { |response|
      @bitcoin_current_value = response[:response][:bpi][:EUR][:rate_float]
      render!
    }.fail { |response|
      puts response
    }

    Bitcoin.get_past_month_price.then { |response|
      @bitcoin_values = response[:response][:bpi]
      render!
    }.fail { |response|
      puts response
    }
  end

  def get_balance_of_rubycoin
    @contract[:instance].balance_of(Web3::Eth.accounts[0]) do |error, result|
      @balance_of_rubycoin = ::BigNumber.new(result)
      render!
    end
  end
end
