require 'rails_helper'

RSpec.describe 'Forecast Service' do
  it 'returns a faraday response', :vcr do
      denver = {:lat=>39.7392, :lon=>-104.9903}
      #binding.pry
      response = WeatherService.get_weather(denver)
      expect(response).to be_a(Hash)
  end

  it 'returns forecast data form longitude and latitude', :vcr do
    denver = {:lat=>39.7392, :lon=>-104.9903}
    weather = WeatherService.get_weather(denver)
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
