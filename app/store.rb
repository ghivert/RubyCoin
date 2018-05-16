class Store
  include Inesita::Injection

  attr_accessor :bitcoin_values
  attr_accessor :bitcoin_current_value

  def init
    @bitcoin_values = {}
    @bitcoin_current_value = nil
    get_bitcoin_prices
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
end
