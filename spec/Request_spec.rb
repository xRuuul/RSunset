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
end