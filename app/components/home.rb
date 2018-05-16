require "date"
require "lib/bitcoin"
require "lib/chart"

require_tree "./home"

module Components
  class Home
    include Inesita::Component

    def render
      div do
        if store.bitcoin_values != {}
          component chart
        end
      end
    end

    private

    def chart
      @chart ||= Chart.new(store.bitcoin_values)
    end
  end
end
