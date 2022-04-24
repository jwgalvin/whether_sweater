require 'rails_helper'

RSpec.describe 'Weather facade' do
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

      facade = WeatherFacade.forecast(@poro)
      #binding.pry
      expect(facade).to be_a(WeatherForecast)
      expect(facade.current_weather).to be_a(Hash)
      expect(facade.daily_weather).to be_a(Array)
      expect(facade.hourly_weather).to be_a(Array)
  end

  it 'has current weather keys', :vcr do

    facade = WeatherFacade.forecast(@poro)
    #binding.pry
    expect(facade.current_weather.count).to eq(10)
    expect(facade.current_weather).to have_key(:datetime)
    expect(facade.current_weather).to have_key(:sunrise)
    expect(facade.current_weather).to have_key(:sunset)
    expect(facade.current_weather).to have_key(:temperature)
    expect(facade.current_weather).to have_key(:feels_like)
    expect(facade.current_weather).to have_key(:humidity)
    expect(facade.current_weather).to have_key(:uvi)
    expect(facade.current_weather).to have_key(:visibility)
    expect(facade.current_weather).to have_key(:conditions)
    expect(facade.current_weather).to have_key(:icon)
  end

  it 'has hourly weather keys', :vcr do

    facade = WeatherFacade.forecast(@poro)
    facade.daily_weather.shift(5).each do |day|
      #binding.pry
      expect(day.count).to eq(7)
      expect(day).to have_key(:date)
      expect(day).to have_key(:sunrise)
      expect(day).to have_key(:sunset)
      expect(day).to have_key(:max_temp)
      expect(day).to have_key(:min_temp)
      expect(day).to have_key(:conditions)
      expect(day).to have_key(:icon)
    end
  end

  it 'has the other keys', :vcr do

    facade = WeatherFacade.forecast(@poro)
    facade.hourly_weather.shift(8).each do |hour|
      #binding.pry
      expect(hour.count).to eq(4)
      expect(hour).to have_key(:time)
      expect(hour).to have_key(:temperature)
      expect(hour).to have_key(:conditions)
      expect(hour).to have_key(:icon)
    end
  end


end
