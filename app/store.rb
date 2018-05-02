class Store
  include Inesita::Injection

  attr_accessor :bitcoin_value

  def init
    @bitcoin_value = {}
  end
end
