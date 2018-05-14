require 'promise'
require 'lib/net'

ENDPOINT = 'https://api.coinmarketcap.com/v2'

module Bitcoin
  class Price
    class << self
      def get_current
        ::Net::HTTP.get(ENDPOINT + '/ticker/1/?convert=EUR')
          .then { |request|
            puts request
            `console.log(#{request.to_n})`
          }.fail { |request|
            puts request
          }
      end
    end
  end
end
