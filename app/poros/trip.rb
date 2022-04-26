class Trip
  attr_reader :id, :end_city, :travel_time, :arrival_weather, :start_city

  def initialize(forecast, route, start, destination)
    @id = nil
    @start_city = start
    @end_city = destination
    @travel_time = format_route(route)
    @arrival_weather = format_forecast(forecast,travel_time)
  end

  def format_route(route)
    message = "Not a Valid Route, May need to book a flight or cabin."
    if route.parse_directions == message
      return message
    else
      return route.eta
    end
  end

  def format_forecast(forecast, travel_time)
    message = "Not a Valid Route, May need to book a flight or cabin."
    if travel_time == message
      message
    else
      eta = DateTime.now.to_i + travel_time.to_i
      message = forecast.hourly_weather.select do |hour|
        Time.at(eta).to_datetime.strftime("%H").to_i == (hour[:time].to_datetime).strftime("%H").to_i
      end
      message.first
    end

    #binding.pry
  end
end
