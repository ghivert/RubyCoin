require 'lib/bitcoin/price'

module Bitcoin
  def self.get_current_price
    Price.get_current
  end

  def self.get_past_month_price
    Price.get_past_month
  end
end
