class Store
  include Inesita::Injection

  attr_accessor :bitcoin_values

  def init
    @bitcoin_values = {}
    get_bitcoin_prices
  end

  private

  def get_bitcoin_prices
    Bitcoin.get_past_month_price.then { |response|
      @bitcoin_values = response[:response][:bpi]
      render!
    }.fail { |response|
      puts response
    }
  end
end
