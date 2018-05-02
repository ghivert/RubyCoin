require './bitcoin/price'

module Bitcoin
  def self.get_current_price
    Price.get_current
  end
end
