require 'lib/bitcoin'

module Components
  class Home
    include Inesita::Component

    def render
      div do
      end
    end
  end
end

Bitcoin.get_current_price
Bitcoin.get_past_month_price
