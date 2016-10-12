require_relative "spec_helper"

describe  RSunset::CurrentWeather do

  dispatcher = RSunset::Dispatcher.new("123")

  it "parses single response correctly" do
    request = RSunset::Current_Weather_Request.create_by_city_name("London","uk")

    stub_request(:get,"http://api.openweathermap.org/data/2.5/weather?q=London,uk&appid=123").to_return(body: '{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"base":"stations","main":{"temp":285.071,"pressure":1029.84,"humidity":60,"temp_min":285.071,"temp_max":285.071,"sea_level":1037.42,"grnd_level":1029.84},"wind":{"speed":4.77,"deg":70.5004},"clouds":{"all":12},"dt":1475781491,"sys":{"message":0.0177,"country":"GB","sunrise":1475734278,"sunset":1475774660},"id":2643743,"name":"London","cod":200}',status: 200)
    response = dispatcher.send_request(request)

    expect(response.number_of_cities).to eq(1)

    city = response.cities[0]
    expect(city.class).to eq(RSunset::CurrentWeather_City)

    expect(city.id).to eq(2643743)
    expect(city.name).to eq("London")
    expect(city.position).to eq({"lon" => -0.13,"lat" => 51.51})

    weather = city.weather
    expect(weather["main"]).to eq("Clouds")
    expect(weather["description"]).to eq("few clouds")

    main = city.main
    expect(main["temp"]).to eq(285.071)
    expect(main["pressure"]).to eq(1029.84)
    expect(main["humidity"]).to eq(60)
  end

  it "parses multi response correctly" do
    request = RSunset::Current_Weather_Request.create_by_several_ids([524901,703448,2643743])

    stub_request(:get,"http://api.openweathermap.org/data/2.5/group?id=524901,703448,2643743&appid=123").to_return(body: '{"cnt":3,"list":[{"coord":{"lon":37.62,"lat":55.75},"sys":{"message":0.1602,"country":"RU","sunrise":1476244567,"sunset":1476282930},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"main":{"temp":269.694,"temp_min":269.694,"temp_max":269.694,"pressure":1026.7,"sea_level":1047.66,"grnd_level":1026.7,"humidity":83},"wind":{"speed":1.13,"deg":349},"clouds":{"all":64},"dt":1476231704,"id":524901,"name":"Moscow"},{"coord":{"lon":30.52,"lat":50.43},"sys":{"message":0.1859,"country":"UA","sunrise":1476245821,"sunset":1476285082},"weather":[{"id":803,"main":"Clouds","description":"broken clouds","icon":"04n"}],"main":{"temp":280.494,"temp_min":280.494,"temp_max":280.494,"pressure":1021.35,"sea_level":1036.23,"grnd_level":1021.35,"humidity":98},"wind":{"speed":5.38,"deg":94.5005},"clouds":{"all":76},"dt":1476231705,"id":703448,"name":"Kiev"},{"coord":{"lon":-0.13,"lat":51.51},"sys":{"message":0.1663,"country":"GB","sunrise":1476253267,"sunset":1476292343},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02n"}],"main":{"temp":281.644,"temp_min":281.644,"temp_max":281.644,"pressure":1027.43,"sea_level":1035.14,"grnd_level":1027.43,"humidity":100},"wind":{"speed":3.33,"deg":43.5005},"clouds":{"all":12},"dt":1476231726,"id":2643743,"name":"London"}]}',status: 200)
    response = dispatcher.send_request(request)

    expect(response.number_of_cities).to eq(3)
    expect(response.cities[0].name).to eq("Moscow")
    expect(response.cities[1].name).to eq("Kiev")
    expect(response.cities[2].name).to eq("London")

    expect(response.cities[2].weather["main"]).to eq("Clouds")
  end


end
