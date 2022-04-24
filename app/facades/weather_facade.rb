class WeatherFacade
  class << self
    def forecast(location)
      response = WeatherService.get_weather(location)
      forecast = {
        current_weather: response[:current],
        hourly_weather: response[:hourly],
        daily_weather: response[:daily].first(5)
          }
    
      WeatherForecast.new(forecast)
    end
  end
end
