class Store
  include Inesita::Injection

  attr_reader :bitcoin_values
  attr_reader :bitcoin_current_value
  attr_reader :rubycoin_balance
  attr_reader :ethereum_balance
  attr_reader :sending
  attr_reader :account
  
  ETH = 1
  RBC = 2

  def init
    contract_interface = JSON.parse(`document.getElementsByName('contract-interface')[0].content`)
    @account = Web3::Eth.account
    @bitcoin_values = {}
    @bitcoin_current_value = nil
    @rubycoin_balance = nil
    @ethereum_balance = nil
    @contract = {
      interface: contract_interface,
      instance:
        ::Web3::Eth.contract(contract_interface[:abi])
                   .at(contract_interface[:networks]["5777"][:address])
    }
    @send_coins = RBC
    @sending = {
      value_content: 0,
      to: ""
    }
    get_bitcoin_prices
    get_rubycoin_balance
    get_ethereum_balance
  end

  def sending_rbc?
    @send_coins == RBC
  end

  def sending_eth?
    @send_coins == ETH
  end

  def send_eth
    @send_coins = ETH
    reset_sending
    render!
  end

  def send_rbc
    @send_coins = RBC
    reset_sending
    render!
  end

  def update_value_content(value)
    @sending[:value_content] = value
  end

  def update_recipient_content(value)
    @sending[:to] = value
  end

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

  def get_rubycoin_balance
    @contract[:instance].balance_of(@account) do |error, result|
      @rubycoin_balance = ::BigNumber.new(result)
      render!
    end
  end

  def get_ethereum_balance
    Web3::Eth.get_balance(@account) do |error, result|
      @ethereum_balance = ::BigNumber.new(Web3.from_wei(result))
      render!
    end
  end

  private

  def reset_sending
    @sending[:value_content] = 0
    @sending[:to] = ""
  end
end
