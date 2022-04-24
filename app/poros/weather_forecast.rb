class WeatherForecast
  attr_reader :id, :current_weather, :hourly_weather, :daily_weather

  def initialize(forecast)
    @current_weather = current(forecast[:current_weather])
    @hourly_weather = hourly(forecast[:hourly_weather])
    @daily_weather = daily(forecast[:daily_weather])
  end

  def current(data)
    #binding.pry
    {
      datetime: Time.at(data[:dt]),
      sunrise: Time.at(data[:sunrise]),
      sunset: Time.at(data[:sunset]),
      conditions: data[:weather].first[:description],
      icon: data[:weather].first[:icon],
      temperature: data[:temp],
      feels_like: data[:feels_like],
      humidity: data[:humidity],
      uvi: data[:uvi],
      visibility: data[:visibility]
    }
  end

  def hourly(data)
    data.map do |select|
      {
        time: Time.at(select[:dt]).strftime('%T'),
        temperature: select[:temp].to_f,
        conditions: select[:weather][0][:description],
        icon: select[:weather][0][:icon]
      }
    end
  end

  def daily(data)
    data.map do |today|
        {
        date: Time.at(today[:dt]).strftime('%F'),
        sunrise: Time.at(today[:sunrise]),
        sunset: Time.at(today[:sunset]),
        conditions: today[:weather][0][:description],
        icon: today[:weather][0][:icon],
        max_temp: today[:temp][:max],
        min_temp: today[:temp][:min]
        }
    end
  end
end
