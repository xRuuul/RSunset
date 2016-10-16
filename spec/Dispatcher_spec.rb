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


  #Stubs contain template response so no parser error gets thrown

  it "generates api call: CURRENT WEATHER BY CITY NAME correctly" do

    request = RSunset::Current_Weather_Request.create_by_city_name("London","uk")

    stub_request(:get,"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=123").to_return(body: '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"base":"stations","main":{"temp":285.071,"pressure":1029.84,"humidity":60,"temp_min":285.071,"temp_max":285.071,"sea_level":1037.42,"grnd_level":1029.84},"wind":{"speed":4.77,"deg":70.5004},"clouds":{"all":12},"dt":1475781491,"sys":{"message":0.0177,"country":"GB","sunrise":1475734278,"sunset":1475774660},"id":2643743,"name":"London","cod":200}',status: 200)
    dispatcher.send_request(request)
  end

  it "generates api call: CURRENT WEATHER BY CITY ID correctly" do

    request = RSunset::Current_Weather_Request.create_by_city_id(2172797)

    stub_request(:get,"http://api.openweathermap.org/data/2.5/weather?id=2172797&appid=123").to_return(body: '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"base":"stations","main":{"temp":285.071,"pressure":1029.84,"humidity":60,"temp_min":285.071,"temp_max":285.071,"sea_level":1037.42,"grnd_level":1029.84},"wind":{"speed":4.77,"deg":70.5004},"clouds":{"all":12},"dt":1475781491,"sys":{"message":0.0177,"country":"GB","sunrise":1475734278,"sunset":1475774660},"id":2643743,"name":"London","cod":200}',status: 200)
    dispatcher.send_request(request)
  end

  it "generates api call: CURRENT WEATHER BY GEO COORDS correctly" do

    request = RSunset::Current_Weather_Request.create_by_geo_coords(35,139)
    stub_request(:get,"http://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=123").to_return(body: '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"base":"stations","main":{"temp":285.071,"pressure":1029.84,"humidity":60,"temp_min":285.071,"temp_max":285.071,"sea_level":1037.42,"grnd_level":1029.84},"wind":{"speed":4.77,"deg":70.5004},"clouds":{"all":12},"dt":1475781491,"sys":{"message":0.0177,"country":"GB","sunrise":1475734278,"sunset":1475774660},"id":2643743,"name":"London","cod":200}',status: 200)
    dispatcher.send_request(request)
  end

  it "generates api call: CURRENT WEATHER BY ZIP CODE correctly" do

    request = RSunset::Current_Weather_Request.create_by_zip_code(12345,"de")
    stub_request(:get,"http://api.openweathermap.org/data/2.5/weather?zip=12345,de&appid=123").to_return(body: '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"base":"stations","main":{"temp":285.071,"pressure":1029.84,"humidity":60,"temp_min":285.071,"temp_max":285.071,"sea_level":1037.42,"grnd_level":1029.84},"wind":{"speed":4.77,"deg":70.5004},"clouds":{"all":12},"dt":1475781491,"sys":{"message":0.0177,"country":"GB","sunrise":1475734278,"sunset":1475774660},"id":2643743,"name":"London","cod":200}',status: 200)
    dispatcher.send_request(request)
  end

  it "generates api call: CURRENT WEATHER BY RECTANGLE ZONE correctly" do

    request = RSunset::Current_Weather_Request.create_by_rectangle_zone([0,1,2,3])
    stub_request(:get,"http://api.openweathermap.org/data/2.5/box/city?bbox=0,1,2,3&cluster=yes&appid=123").to_return(body: '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"base":"stations","main":{"temp":285.071,"pressure":1029.84,"humidity":60,"temp_min":285.071,"temp_max":285.071,"sea_level":1037.42,"grnd_level":1029.84},"wind":{"speed":4.77,"deg":70.5004},"clouds":{"all":12},"dt":1475781491,"sys":{"message":0.0177,"country":"GB","sunrise":1475734278,"sunset":1475774660},"id":2643743,"name":"London","cod":200}',status: 200)
    dispatcher.send_request(request)
  end

  it "generates api call: CURRENT WEATHER BY CYCLE correctly" do

    request = RSunset::Current_Weather_Request.create_by_cycle(1,2,10)
    stub_request(:get,"http://api.openweathermap.org/data/2.5/find?lat=1&lon=2&cnt=10&cluster=yes&appid=123").to_return(body: '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"base":"stations","main":{"temp":285.071,"pressure":1029.84,"humidity":60,"temp_min":285.071,"temp_max":285.071,"sea_level":1037.42,"grnd_level":1029.84},"wind":{"speed":4.77,"deg":70.5004},"clouds":{"all":12},"dt":1475781491,"sys":{"message":0.0177,"country":"GB","sunrise":1475734278,"sunset":1475774660},"id":2643743,"name":"London","cod":200}',status: 200)
    dispatcher.send_request(request)
  end

  it "generates api call: CURRENT WEATHER BY SEVERAL IDS correctly" do

    request = RSunset::Current_Weather_Request.create_by_several_ids([1,2,50,600])
    stub_request(:get,"http://api.openweathermap.org/data/2.5/group?id=1,2,50,600&appid=123").to_return(body: '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"base":"stations","main":{"temp":285.071,"pressure":1029.84,"humidity":60,"temp_min":285.071,"temp_max":285.071,"sea_level":1037.42,"grnd_level":1029.84},"wind":{"speed":4.77,"deg":70.5004},"clouds":{"all":12},"dt":1475781491,"sys":{"message":0.0177,"country":"GB","sunrise":1475734278,"sunset":1475774660},"id":2643743,"name":"London","cod":200}',status: 200)
    dispatcher.send_request(request)
  end
end