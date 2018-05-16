module Components
  class Home
    class Chart
      include Inesita::Component

      def initialize(bitcoin_values)
        @chart = ::Chart.new height: "500px", options: {
          type: "line",
          data: {
            labels: bitcoin_values.keys.map { |date| ::Date.parse date }.map { |date| date.strftime "%m/%d/%Y" },
            datasets: [{
              data: bitcoin_values.values,
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

      def render
        component @chart
      end
    end
  end
end
