require "date"
require "lib/bitcoin"
require "lib/chart"

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
      @chart ||= initialize_chart
    end

    def initialize_chart
      @chart = ::Chart.new height: "500px", options: {
        type: "line",
        data: {
          labels: store.bitcoin_values.keys.map { |date| ::Date.parse date }.map { |date| date.strftime "%m/%d/%Y" },
          datasets: [{
            data: store.bitcoin_values.values,
            backgroundColor: "rgb(254, 232, 185)",
            borderColor: "rgb(252, 161, 21)",
            borderWidth: 2,
            pointRadius: 0
          }]
        },
        options: {
          legend: {
            display: false
          },
          tooltips: {
            mode: "nearest"
          },
          hover: {
            intersect: false
          }
        }
      } if @chart == nil
    end
  end
end
