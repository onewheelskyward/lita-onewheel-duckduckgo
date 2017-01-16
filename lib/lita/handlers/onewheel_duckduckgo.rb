require 'rest-client'

module Lita
  module Handlers
    class OnewheelDuckDuckGo < Handler
      route /^duck\s+(.*)$/, :search, command: true

      def search(response)
        query = response.matches[0][0]
        Lita.logger.debug "Querying for #{query}"
        result = get_result(query)
        Lita.logger.debug "Result: #{result}"
        reply = "DuckDuckGo Result: #{result['Abstract'][0..250]}"
        Lita.logger.debug "Reply: #{reply}"
        response.reply reply
      end

      def get_result(query)
        result = RestClient.get("http://api.duckduckgo.com/?q=#{query}&format=json")
      end

      Lita.register_handler(self)
    end
  end
end
