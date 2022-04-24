require 'rails_helper'

RSpec.describe 'Weather facade' do
  it 'returns a faraday response', :vcr do
      denver = {:lat=>39.7392, :lon=>-104.9903}
      facade = WeatherFacade.forecast(denver)
      #binding.pry
      expect(facade).to be_a(WeatherForecast)
      expect(facade.current_weather).to be_a(Hash)
      expect(facade.daily_weather).to be_a(Array)
      expect(facade.hourly_weather).to be_a(Array)
  end

  it 'has current weather keys', :vcr do
    denver = {:lat=>39.7392, :lon=>-104.9903}
    facade = WeatherFacade.forecast(denver)
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
    denver = {:lat=>39.7392, :lon=>-104.9903}
    facade = WeatherFacade.forecast(denver)
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
    denver = {:lat=>39.7392, :lon=>-104.9903}
    facade = WeatherFacade.forecast(denver)
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
