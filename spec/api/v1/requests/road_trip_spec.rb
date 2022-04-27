require 'rails_helper'

RSpec.describe "Road Trip controller" do
  before(:each) do
    @user = User.create!(email: "play@games.com", password: "12345")

    @happy_params =
    {
      "origin": "Denver,CO",
      "destination": "New Your, Ny",
      "api_key": @user.api_key
    }
    @sad_params1 = {
      "origin": "Denver,CO",
      "destination": "Honolulu, HI",
      "api_key": @user.api_key
    }
    @sad_params2 = {
      "origin": "Denver,CO",
      "destination": "Honolulu, HI",
      "api_key": "scallawagy"
    }

    @headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  it "tests a happy request", :vcr do
    post "/api/v1/road_trip", headers: @headers, params: @happy_params.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed_data).to have_key(:data)
    expect(parsed_data[:data][:type]).to eq('roadtrip')
    expect(parsed_data[:data][:attributes].count).to eq(4)
    expect(parsed_data[:data][:attributes][:start_city]).to eq(@happy_params[:origin])
    expect(parsed_data[:data][:attributes][:end_city]).to eq(@happy_params[:destination])
    expect(parsed_data[:data][:attributes]).to have_key(:travel_time)
    expect(parsed_data[:data][:attributes]).to have_key(:arrival_weather)
  end

  it "tests a sad path, invalid destination", :vcr do
    post "/api/v1/road_trip", headers: @headers, params: @sad_params1.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(200)
    expect(parsed_data[:data][:attributes][:travel_time]).to eq("Not a Valid Route, May need to book a flight or cabin.")
    expect(parsed_data[:data][:attributes][:arrival_weather]).to eq("Not a Valid Route, May need to book a flight or cabin.")
  end

  it "tests a sad path, invalid api_key", :vcr do
    post "/api/v1/road_trip", headers: @headers, params: @sad_params2.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    #binding.pry
    expect(response.status).to eq(401)
    expect(parsed_data[:message]).to eq("Naughty Naughty, invalid key")
  end
end
