class RoadTripFacade
  class << self
    def create_trip(start, destination)
      arrival = MapquestFacade.geocode(destination)
      route = MapquestFacade.route(start, destination)
      forecast = WeatherFacade.forecast(arrival)
      Trip.new(forecast, route, start, destination)
    end
  end
end
