ENDPOINT = 'https://api.coinmarketcap.com/v2'

module Bitcoin
  class Price
    class << self
      def get_current
        # ::HTTP.get(ENDPOINT + '/ticker/1?convert=EUR') do |response|
        #   if response.ok?
        #     puts response.body
        #     puts response.json
        #   else
        #     puts "Wrong Request #{response}"
        #   end
      end
    end
  end
end
