require 'rails_helper'

RSpec.describe "RoadTripFacade" do
  before(:each) do
    @start = "denver,co"
    @destination = 'sioux falls, sd'
    @destination2 = 'honolulu, hi'
    @trip = RoadTripFacade.create_trip(@start, @destination)
    @trip2 =RoadTripFacade.create_trip(@start, @destination2)
  end
  
  it "collates 3 facades and makes a poro", :vcr do

    expect(@trip).to be_a(Trip)
    expect(@trip.start_city).to eq(@start)
    expect(@trip.end_city).to eq(@destination)
  end

  it "Happy poro has the correct attributes", :vcr do
    expect(@trip.arrival_weather).to be_a(Hash)
    expect(@trip.arrival_weather.count).to eq(4)
    expect(@trip.arrival_weather[:temperature]).to be_a(Float)
    expect(@trip.arrival_weather[:conditions]).to be_a(String)
    expect(@trip.arrival_weather[:icon]).to be_a(String)
    expect(@trip.end_city).to be_a(String)
    expect(@trip.start_city).to be_a(String)
    expect(@trip.travel_time).to be_a(String)
  end

  it "has sad path messages when sad", :vcr do
    expect(@trip2).to be_a(Trip)
    expect(@trip2.travel_time).to eq("Not a Valid Route, May need to book a flight or cabin.")
    expect(@trip2.arrival_weather).to eq("Not a Valid Route, May need to book a flight or cabin.")
  end

end
