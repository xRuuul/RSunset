require_relative "spec_helper"

describe RSunset::Dispatcher do

  dispatcher = RSunset::Dispatcher.new("123")

  it "handles server response correctly" do

    request = RSunset::Current_Weather_Request.create_by_city_name("London","uk")

    #Server Error 401
    stub_request(:get,"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=123").to_return(status: 401)
    expect{
      dispatcher.send_request(request)
    }.to raise_exception(RuntimeError,"Server returning code 401")

  end

  it "generates api call: CURRENT WEATHER BY CITY NAME and parses respone correctly" do

    #Make request

    request = RSunset::Current_Weather_Request.create_by_city_name("London","uk")

    stub_request(:get,"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=123")
    dispatcher.send_request(request)

    #Parse response
    #TODO
  end

end