require 'promise'
require 'lib/net'

ENDPOINT = 'https://api.coindesk.com/v1'

module Bitcoin
  class Price
    class << self
      def get_current
        ::Net::HTTP.get(ENDPOINT + '/bpi/currentprice/EUR.json')
          .then { |request|
            puts request
            `console.log(#{request.to_n})`
          }.fail { |request|
            puts request
          }
      end

      def get_past_month
        ::Net::HTTP.get(ENDPOINT + '/bpi/historical/close.json?currency=EUR')
          .then { |request|
            puts request
          }.fail { |request|
            puts request
          }
      end
    end
  end
end
