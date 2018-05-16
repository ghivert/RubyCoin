module Components
  class Home
    class Chart
      include Inesita::Component

      def initialize(bitcoin_values)
        @chart = ::Chart.new height: "500px", options: {
          type: "line",
          data: generate_data(bitcoin_values),
          options: generate_options
        }
      end

      def render
        component @chart
      end

      private

      def generate_data(bitcoin_values)
        {
          labels: bitcoin_values.keys.map { |date| ::Date.parse date }.map { |date| date.strftime "%m/%d/%Y" },
          datasets: [{
            data: bitcoin_values.values,
            backgroundColor: "rgb(254, 232, 185)",
            borderColor: "rgb(252, 161, 21)",
            borderWidth: 2,
            pointRadius: 0
          }]
        }
      end

      def generate_options
        {
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
      end
    end
  end
end
