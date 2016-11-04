
module RSunset
  class Request

    attr_reader :request_type
    attr_reader :sub_request_type
    attr_accessor :options

    def initialize(request_type,sub_request_type,options)
      @response = nil
      @request_type = request_type
      @sub_request_type = sub_request_type
      @options = options
    end

    # Response handling ==========

    def attach_response(response)
      @response = response
    end

    def remove_response
      @response = nil
    end

    def has_response_attached
      @response != nil
    end

    def get_response
      @response
    end

    #=============================
  end

  class Current_Weather_Request < Request

    private_class_method :new

    def initialize(sub_request_type,options)
      super(:current_weather,sub_request_type,options)
    end

    #Single Request ==============

    def self.create_by_city_name(city_name,country_code = nil)
      identification = city_name
      if(country_code != nil)
        identification << "," <<country_code
      end
      options = {:q => identification}
      new(:by_city_name,options)
    end

    def self.create_by_city_id(id)
      options = {:id => id.to_s}
      new(:by_city_id,options)
    end

    def self.create_by_geo_coords(lat,lng)
      options = {:lat => lat.to_s,:lon => lng.to_s}
      new(:by_geo_coords,options)
    end

    def self.create_by_zip_code(zip_code,country_code = nil)
      identification = zip_code.to_s
      if(country_code != nil)
        identification << "," << country_code
      end
      options = {:zip => identification}
      new(:by_zip_code,options)
    end

    #Multi Request ==============

    def self.create_by_rectangle_zone(bounding_box,cluster = true)
      bbox = ""
      bounding_box.each{ |v| bbox << v.to_s << ","}
      bbox = bbox.chomp(",")
      if cluster
        c = "yes"
      else
        c = "no"
      end
      options = {:bbox => bbox, :cluster => c}
      new(:by_rectangle_zone,options)
    end

    def self.create_by_cycle(lat,lng,cnt,cluster = true)
      if cluster
        c = "yes"
      else
        c = "no"
      end

      options = {:lat => lat.to_s,:lon => lng.to_s,:cnt => cnt.to_s,:cluster => c}
      new(:by_cycle,options)
    end

    def self.create_by_several_ids(ids)
      identification = ""
      ids.each{ |id| identification << id.to_s << "," }
      identification = identification.chomp(",")

      options = {:id => identification}
      new(:by_multi_id,options)
    end
  end

  class Forecast_5Day_Request < Request

    private_class_method :new

    def initialize(sub_request_type,options)
      super(:forecast_5day,sub_request_type,options)
    end

    def self.create_by_city_name(city_name,country_code = nil)
      identification = city_name
      if(country_code != nil)
        identification << "," <<country_code
      end
      options = {:q => identification}
      new(:by_city_name,options)
    end

    def self.create_by_city_id(id)
      options = {:id => id.to_s}
      new(:by_city_id,options)
    end

    def self.create_by_geo_coords(lat,lng)
      options = {:lat => lat.to_s,:lon => lng.to_s}
      new(:by_geo_coords,options)
    end
  end

  class Pollution_Request < Request

    private_class_method :new

    def initialize(sub_request_type,options)
      super(:pollution,sub_request_type,options)
    end

    def self.create_c0(lat,lng,time)
      options = {:lat => lat, :lon => lng, :time => time.utc.iso8601}
      new(:c0,options)
    end
  end
end