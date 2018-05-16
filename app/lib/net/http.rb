# Core libraries
require 'promise'
require 'json'

# Complete rewrite in order to skip opal-jquery dependency.
module Net
  class HTTP
    class << self
      def get(url, is_json_content: true)
        promise = Promise.new
        `
          var request = new XMLHttpRequest();

          request.onreadystatechange = function(event) {
            if (this.readyState === XMLHttpRequest.DONE) {
              if (this.status === 200) {
                #{promise.resolve create_response(`this`, is_json_content)}
              } else {
                #{promise.reject create_response(`this`, false)}
              }
            }
          }

          request.open('GET', #{url})
          request.send(null)
        `
        promise
      end

      private

      def create_response(object, is_json_content)
        response = `object.response`
        {
          response: is_json_content ? ::JSON.parse(response) : response,
          response_type: `object.responseType`,
          response_url: `object.responseURL`,
          status: `object.status`,
          status_text: `object.statusText`
        }
      end
    end
  end
end
