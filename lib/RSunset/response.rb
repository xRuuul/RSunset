
module RSunset
  class CurrentWeather

    attr_reader :number_of_cities

    def initialize
      @number_of_cities = 0
    end

    def parse_json(json)
      object = JSON.parse(json)

      #

    end

    def parse_city(city)

    end

    private :parse_city
  end

  class CurrentWeather_City

  end

end