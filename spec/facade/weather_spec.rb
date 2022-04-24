require 'rails_helper'

RSpec.describe 'Weather facade' do
  it 'returns a faraday response', :vcr do
      denver = {:lat=>39.7392, :lon=>-104.9903}
      facade = WeatherFacade.forecast(denver)
      #binding.pry
      expect(facade).to be_a(WeatherFacade)
  end


end
