# Core libraries
require "date"

# Libraries
require "lib/bitcoin"
require "lib/chart"

# Home inside components
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
