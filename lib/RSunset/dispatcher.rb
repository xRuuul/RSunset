
require "http"

module RSunset

  $server = "http://api.openweathermap.org/data/2.5/"
  $id_key = "APPID"

  class Dispatcher

    attr_accessor :std_parameters

    def initialize(api_key)
      @std_parameters = {:appid => api_key.to_s}
    end

    def set_api_key(api_key)
      @std_parameters[:appid] = api_key
    end

    def get_api_key
      @std_parameters[:appid]
    end

    def set_custom_parameter(key,value)
      @std_parameters[key] = value
    end

    def remove_custom_parameter(key)
      @std_parameters.delete(key)
    end


    def send_request(request)
      response = HTTP.get(get_request_url(request), :params => get_request_params(request).merge(std_parameters))
      if(response.code == 200)
        #Response is valid
      else
        request.remove_response
        raise "Server returning code #{response.code}"
      end
    end

    private

    def get_request_url(request)
      type = request.request_type
      subtype = request.sub_request_type

      case type
        when :current_weather
          url = $server + "weather"
          case subtype
            when :by_rectangle_zone
              url = $server + "box/city"
            when :by_cycle
              url = $server + "find"
            when :by_multi_id
              url = $server + "group"
          end
      end

      url
    end

    def get_request_params(request)
      request.options
    end

  end
end