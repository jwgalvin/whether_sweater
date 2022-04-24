class WeatherService
  class << self
    def get_weather(loc)
      #binding.pry
      response = conn.get("/data/2.5/onecall?lat=#{loc[:lat]}&lon=#{loc[:lon]}&units=imperial")
      parse_data(response)
    end

    private

    def conn
      Faraday.new(url: 'https://api.openweathermap.org') do |fard|
        fard.params['appid'] = ENV['weather_key']
      end
    end

    def parse_data(response)
      data = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
