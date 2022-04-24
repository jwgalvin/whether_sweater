class MapquestFacade
  class << self
    def coords(location)
      data = MapquestService.gps(location)
      CoordPoro.new(data[:results])
    end

    def route(address, end_address)
      json = MapquestService.routing(address, end_address)
      route = Route.new(json[:route])
    end
  end
end
