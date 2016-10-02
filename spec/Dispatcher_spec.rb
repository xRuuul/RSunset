require_relative "spec_helper"

describe RSunset::Dispatcher do

  dispatcher = RSunset::Dispatcher.new("123")

  it "generates correct api call: CURRENT WEATHER BY CITY NAME" do
    request = RSunset::Current_Weather_Request.create_by_city_name("London","uk")

    stub_request(:get,"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=123")
    dispatcher.send_request(request)

  end

end