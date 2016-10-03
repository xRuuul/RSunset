
module RSunset
  class CurrentWeather

    def initialize(json)
      @cities = []
      parse_json(json)
    end

    def number_of_cities
      @cities.count
    end

    def parse_json(json)
      object = JSON.parse(json)
      #Either List of cities or one entry

      if object.key?("cnt") && object.key?("list")
        #Multi Request
        array = object["list"]
        array.each do |city_data|
          city = CurrentWeather_City.new(city_data)
          cities.push(city)
        end
      else
        #Single Request
        city = CurrentWeather_City.new(object)
        cities.push(city)
      end

    end

    private :parse_json
  end

  class CurrentWeather_City

    attr_reader :id
    attr_reader :name
    attr_reader :position

    def initialize(data)
      parse_hash(data)
    end

    def parse_hash(data)

      @id = data["id"]
      @name = data["name"]
      @position = data["coord"]

      @weather = data["weather"]
      @main = data["main"]
      @wind = data["wind"]
      @clouds = data["clouds"]["all"]
      @rain = data["rain"]["3h"]
      @snow = data["snow"]["3h"]
      @time = data["dt"]
      @sunrise = data["sys"]["sunrise"]
      @sunset = data["sys"]["sunset"]
    end

    private :parse_hash
  end

end