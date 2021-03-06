require 'rails_helper'

RSpec.describe 'weather Service' do
  before(:each)   do
    responded =  [{:providedLocation=>{:location=>"Pueblo,CO"},
  :locations=>
   [{:street=>"",
     :adminArea6=>"",
     :adminArea6Type=>"Neighborhood",
     :adminArea5=>"Pueblo",
     :adminArea5Type=>"City",
     :adminArea4=>"Pueblo County",
     :adminArea4Type=>"County",
     :adminArea3=>"CO",
     :adminArea3Type=>"State",

     :adminArea1=>"US",
     :adminArea1Type=>"Country",
     :postalCode=>"",
     :geocodeQualityCode=>"A5XAX",
     :geocodeQuality=>"CITY",
     :dragPoint=>false,
     :sideOfStreet=>"N",
     :linkId=>"282040865",
     :unknownInput=>"",
     :type=>"s",
     :latLng=>{:lat=>38.265425, :lng=>-104.610415},
     :displayLatLng=>{:lat=>38.265425, :lng=>-104.610415},
     :mapUrl=>
      "http://www.mapquestapi.com/staticmap/v5/map?key=ERsN8MepXYCIcFKsTwHRDP5muyWI5wPJ&type=map&size=225,160&locations=38.265425,-104.610415|marker-sm-50318A-1
&scalebar=true&zoom=12&rand=-1528652559"},
    {:street=>"",
     :adminArea6=>"",
     :adminArea6Type=>"Neighborhood",
     :adminArea5=>"",
     :adminArea5Type=>"City",
     :adminArea4=>"Pueblo County",
     :adminArea4Type=>"County",
     :adminArea3=>"CO",
     :adminArea3Type=>"State",
     :adminArea1=>"US",
     :adminArea1Type=>"Country",
     :postalCode=>"",
     :geocodeQualityCode=>"A4XAX",
     :geocodeQuality=>"COUNTY",
     :dragPoint=>false,
     :sideOfStreet=>"N",
     :linkId=>"282932014",
     :unknownInput=>"",
     :type=>"s",
     :latLng=>{:lat=>38.265425, :lng=>-104.610415},
     :displayLatLng=>{:lat=>38.265425, :lng=>-104.610415},
     :mapUrl=>
      "http://www.mapquestapi.com/staticmap/v5/map?key=ERsN8MepXYCIcFKsTwHRDP5muyWI5wPJ&type=map&size=225,160&locations=38.265425,-104.610415|marker-sm-50318A-2
      &scalebar=true&zoom=9&rand=280884538"}]}]

      @poro = Coord.new(responded)
  end

  it 'returns a faraday response', :vcr do

      response = WeatherService.get_weather(@poro)
      #binding.pry
      expect(response).to be_a(Hash)
  end

  it 'returns forecast data form longitude and latitude', :vcr do

    weather = WeatherService.get_weather(@poro)
    #binding.pry
    expect(weather[:current]).to have_key(:dt)
    expect(weather[:current]).to have_key(:sunrise)
    expect(weather[:current]).to have_key(:sunset)
    expect(weather[:current]).to have_key(:temp)
    expect(weather[:current]).to have_key(:feels_like)
    expect(weather[:current]).to have_key(:humidity)
    expect(weather[:current]).to have_key(:uvi)
    expect(weather[:current]).to have_key(:visibility)
    expect(weather[:current][:weather][0]).to have_key(:description)
    expect(weather[:current][:weather][0]).to have_key(:icon)
    weather[:daily].shift(5).each do |day|
      expect(day).to have_key(:dt)
      expect(day).to have_key(:sunrise)
      expect(day).to have_key(:sunset)
      expect(day[:temp]).to have_key(:max)
      expect(day[:temp]).to have_key(:min)
      expect(day[:weather][0]).to have_key(:description)
      expect(day[:weather][0]).to have_key(:icon)
    end
    weather[:hourly].shift(8).each do |hour|
      expect(hour).to have_key(:dt)
      expect(hour).to have_key(:temp)
      expect(hour[:weather][0]).to have_key(:description)
      expect(hour[:weather][0]).to have_key(:icon)
    end
  end
end
