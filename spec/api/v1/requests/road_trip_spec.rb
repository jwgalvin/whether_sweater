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

    @headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  it "tests a happy request", :vcr do

    post "/api/v1/road_trip", headers: @headers, params: @happy_params.to_json

  end
end
