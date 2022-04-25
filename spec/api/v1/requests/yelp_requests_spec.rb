require 'rails_helper'

RSpec.describe "YelpController" do
  it "does stuff in the controller", :vcr do
    #binding.pry
    start = "westminster, co"
    destination = "parker, co"
    cuisine = 'mexican'
    departure_time = Time.new(2022, 4, 25, 15, 5, 5)
    get "/api/v1/munchies?start=#{start}&destination=#{destination}&food=#{cuisine}"

    expect(response.status).to be_successful
    #binding.pry
    expect(response.body).to have_key('data')
    expect(response.body).to be_a(Hash)

  end
end
