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



end
