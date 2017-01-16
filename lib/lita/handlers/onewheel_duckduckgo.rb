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
        reply = 'DuckDuckGo Result: '
        if result['Abstract'].empty?
          reply += result['AbstractURL']
        else
          reply += result['Abstract'][0..250]
        end
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
