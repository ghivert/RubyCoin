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
      # Shortcuts for repetitive values
      bitcoin_values = store.bitcoin_values
      bitcoin_current_value = store.bitcoin_current_value

      if bitcoin_values != {} && bitcoin_current_value != nil
        div.card do
          variation = compute_diff_percentage(bitcoin_current_value, bitcoin_values)

          div.card_header__variations do
            component VariationCell.new("#{bitcoin_current_value.round(2)} €", "Today")
            div style: "border-right: 1px solid rgba(0, 40, 100, 0.12);"
            component VariationCell.new("#{variation.round(2)} %", "Since yesterday") unless variation.nil?
          end
          component chart
        end
      end
    end

    private

    def chart
      @chart ||= Chart.new(store.bitcoin_values)
    end

    def compute_diff_percentage(today_value, values)
      yesterday_value = values[::Date.today.prev_day.to_s]

      if yesterday_value.nil?
        nil
      else
        ((today_value - yesterday_value) * 100) / yesterday_value
      end
    end
  end
end
