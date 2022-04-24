class MapquestFacade
  class << self
    def geocode(location)
      data = MapquestService.gps(location)
      #binding.pry
      Coord.new(data[:results])
    end

    def route(address, end_address)
      json = MapquestService.routing(address, end_address)
      route = Route.new(json[:route])
    end
  end
end
