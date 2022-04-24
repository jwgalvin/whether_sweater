require 'rails_helper'

RSpec.describe 'Forecast Service' do
  it 'returns a faraday response', :vcr do
      conn = WeatherService.connection
      expect(connection).to be_a(Faraday::Connection)
  end

  it 'returns forecast data form longitude and latitude', :vcr do
    data = {:lat=>35.346543, :lng=>-96.765434}
    weather = WeatherService.get_weather(data[:lat], data[:lng])
    expect(forecast).to be_a Hash
    expect(forecast[:current]).to have_key(:dt)
    expect(forecast[:current]).to have_key(:sunrise)
    expect(forecast[:current]).to have_key(:sunset)
    expect(forecast[:current]).to have_key(:temp)
    expect(forecast[:current]).to have_key(:feels_like)
    expect(forecast[:current]).to have_key(:humidity)
    expect(forecast[:current]).to have_key(:uvi)
    expect(forecast[:current]).to have_key(:visibility)
    expect(forecast[:current][:weather][0]).to have_key(:description)
    expect(forecast[:current][:weather][0]).to have_key(:icon)
    forecast[:daily].shift(5).each do |day|
      expect(day).to have_key(:dt)
      expect(day).to have_key(:sunrise)
      expect(day).to have_key(:sunset)
      expect(day[:temp]).to have_key(:max)
      expect(day[:temp]).to have_key(:min)
      expect(day[:weather][0]).to have_key(:description)
      expect(day[:weather][0]).to have_key(:icon)
    end
    forecast[:hourly].shift(8).each do |hour|
      expect(hour).to have_key(:dt)
      expect(hour).to have_key(:temp)
      expect(hour[:weather][0]).to have_key(:description)
      expect(hour[:weather][0]).to have_key(:icon)
    end
  end
end
