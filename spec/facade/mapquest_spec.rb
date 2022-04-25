require 'rails_helper'

RSpec.describe MapquestFacade do
  it 'gets the gps data points', :vcr do
    gps = MapquestFacade.geocode("denver, co")
    expect(gps).to be_a(Coord)
  end

  it "tests the routing I imported from other IC", :vcr do
    start = 'denver, co'
    destination = 'ft.collins, co'
    trip = MapquestFacade.route(start, destination)
    expect(trip).to be_a(Route)
    expect(trip.distance).to be_a(Float)
    expect(trip.eta).to be_a(String)
    expect(trip.parse_directions).to be_a(Array)
  end
end
