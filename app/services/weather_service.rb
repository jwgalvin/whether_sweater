class WeatherService
  class << self
    def get_weather(loc)
      response = conn.get("/data/2.5/onecall?lat=#{loc.lat}&lon=#{coords.lon}&units=imperial")
    end

    private

    def conn
      Farday.new(url: 'https://api.openweathermap.org') do |fard|
        fard.params['appid'] = ENV['weather_key']
      end
    end

    def parse_data(response)
      data = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
