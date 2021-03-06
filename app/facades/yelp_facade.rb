class YelpFacade
  class << self
    def get_munchies(cuisine, start, destination)
      city = MapquestFacade.geocode(destination)
      route = MapquestFacade.route(start,destination)
      time_arrival = Time.now.to_i + route.eta.to_i
      data = YelpService.yelp_search(cuisine, time_arrival, destination)
      forecast = WeatherFacade.forecast(city)
      both = []
      both << route
      both << data
      both << forecast
    end
  end
end
