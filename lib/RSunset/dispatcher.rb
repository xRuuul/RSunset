
require "http"
require_relative "response"

module RSunset

  class Dispatcher

    attr_accessor :std_parameters
    attr_accessor :server
    attr_accessor :pollution_server


    def initialize(api_key)
      @std_parameters = {:appid => api_key.to_s}
      @server = "http://api.openweathermap.org/data/2.5/"
      @pollution_server = "http://api.openweathermap.org/pollution/v1/"
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
      response_object = nil
      if(response.code == 200)
        #Response is valid
        begin
          case request.request_type
            when :current_weather
              response_object = CurrentWeather.new(response.to_s)
            when :forecast_5day
              response_object = Forecast_5Day.new(response.to_s)
          end
        rescue JSON::ParserError => e
          raise "Parser error: #{e.message}"
        end

      else
        request.remove_response
        raise "Server returning code #{response.code} for #{get_request_url(request)}"
      end

      response_object
    end

    private

    def get_request_url(request)
      type = request.request_type
      subtype = request.sub_request_type

      case type
        when :current_weather
          url = @server + "weather"
          case subtype
            when :by_rectangle_zone
              url = @server + "box/city"
            when :by_cycle
              url = @server + "find"
            when :by_multi_id
              url = @server + "group"
          end
        when :forecast_5day
          url = @server + "forecast"
        when :pollution
          lat = request.options[:lat]
          lon = request.options[:lon]
          time = request.options[:time]
          case subtype
            when :co
              url = "#{@pollution_server}co/#{lat},#{lon}/#{time}.json"
            when :o3
              url = "#{@pollution_server}o3/#{lat},#{lon}/#{time}.json"
          end
      end

      url
    end

    def get_request_params(request)
      case request.request_type
        when :pollution
          return {}
        else
          return request.options
      end
    end

  end
end