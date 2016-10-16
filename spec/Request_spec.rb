require_relative "spec_helper"

describe RSunset::Current_Weather_Request do
  it "has correct id" do
    request = RSunset::Current_Weather_Request.create_by_city_name("A")
    expect(request.request_type).to eq(:current_weather)
  end

  it "creates instance by city name and country code correctly" do
    request = RSunset::Current_Weather_Request.create_by_city_name("a","b")
    expect(request.options[:q]).to eq("a,b")
    request = RSunset::Current_Weather_Request.create_by_city_name("a")
    expect(request.options[:q]).to eq("a")

    expect(request.sub_request_type).to eq(:by_city_name)
  end

  it "creates instance by city id correctly" do
    request = RSunset::Current_Weather_Request.create_by_city_id(123)
    expect(request.options[:id]).to eq("123")

    expect(request.sub_request_type).to eq(:by_city_id)
  end

  it "creates instance by geo coordinates correctly" do
    request = RSunset::Current_Weather_Request.create_by_geo_coords(12.34,23.45)
    expect(request.options[:lat]).to eq("12.34")
    expect(request.options[:lon]).to eq("23.45")

    expect(request.sub_request_type).to eq(:by_geo_coords)
  end

  it "creates instance by zip code correctly" do
    request = RSunset::Current_Weather_Request.create_by_zip_code(94040,"us")
    expect(request.options[:zip]).to eq("94040,us")
    request = RSunset::Current_Weather_Request.create_by_zip_code(94040)
    expect(request.options[:zip]).to eq("94040")

    expect(request.sub_request_type).to eq(:by_zip_code)
  end

  it "creates instance by rectangle zone correctly" do
    request = RSunset::Current_Weather_Request.create_by_rectangle_zone([1.1,2.2,3.3,4.4])
    expect(request.options[:bbox]).to eq("1.1,2.2,3.3,4.4")
    expect(request.options[:cluster]).to eq("yes")
    request = RSunset::Current_Weather_Request.create_by_rectangle_zone([1.1,2.2,3.3,4.4],true)
    expect(request.options[:bbox]).to eq("1.1,2.2,3.3,4.4")
    expect(request.options[:cluster]).to eq("yes")
    request = RSunset::Current_Weather_Request.create_by_rectangle_zone([1,2,3,4],false)
    expect(request.options[:bbox]).to eq("1,2,3,4")
    expect(request.options[:cluster]).to eq("no")

    expect(request.sub_request_type).to eq(:by_rectangle_zone)
  end

  it "creates instance by cycle correctly" do
    request = RSunset::Current_Weather_Request.create_by_cycle(1,2,10)
    expect(request.options[:lat]).to eq("1")
    expect(request.options[:lon]).to eq("2")
    expect(request.options[:cnt]).to eq("10")
    expect(request.options[:cluster]).to eq("yes")
    request = RSunset::Current_Weather_Request.create_by_cycle(1,2,10,true)
    expect(request.options[:lat]).to eq("1")
    expect(request.options[:lon]).to eq("2")
    expect(request.options[:cnt]).to eq("10")
    expect(request.options[:cluster]).to eq("yes")
    request = RSunset::Current_Weather_Request.create_by_cycle(1,2,10,false)
    expect(request.options[:lat]).to eq("1")
    expect(request.options[:lon]).to eq("2")
    expect(request.options[:cnt]).to eq("10")
    expect(request.options[:cluster]).to eq("no")

    expect(request.sub_request_type).to eq(:by_cycle)
  end

  it "creates instance by several ids correctly" do
    request = RSunset::Current_Weather_Request.create_by_several_ids([1,2,3,4,5,6])
    expect(request.options[:id]).to eq("1,2,3,4,5,6")

    expect(request.sub_request_type).to eq(:by_multi_id)
  end
end

describe RSunset::Forecast_5Day_Request do
  it "has correct id" do
    request = RSunset::Forecast_5Day_Request.create_by_city_name("A")
    expect(request.request_type).to eq(:forecast_5day)
  end

  it "creates instance by city name and country code correctly" do
    request = RSunset::Forecast_5Day_Request.create_by_city_name("a","b")
    expect(request.options[:q]).to eq("a,b")
    request = RSunset::Forecast_5Day_Request.create_by_city_name("a")
    expect(request.options[:q]).to eq("a")

    expect(request.sub_request_type).to eq(:by_city_name)
  end

  it "creates instance by city id correctly" do
    request = RSunset::Forecast_5Day_Request.create_by_city_id(123)
    expect(request.options[:id]).to eq("123")

    expect(request.sub_request_type).to eq(:by_city_id)
  end

  it "creates instance by geo coordinates correctly" do
    request = RSunset::Forecast_5Day_Request.create_by_geo_coords(12.34,23.45)
    expect(request.options[:lat]).to eq("12.34")
    expect(request.options[:lon]).to eq("23.45")

    expect(request.sub_request_type).to eq(:by_geo_coords)
  end
end
