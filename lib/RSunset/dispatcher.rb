
require "http"

module RSunset

  $server = "http://api.openweathermap.org"
  $id_key = "APPID"

  class Dispatcher
    def initialize(api_key)
      @api_key = api_key
    end


    def send_request(request)
      response = HTTP.get($server, :params => parse_request(request))
    end

    private

    def parse_request(request)

    end

  end
end