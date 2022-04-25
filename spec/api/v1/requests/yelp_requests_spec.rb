require 'rails_helper'

RSpec.describe "YelpController" do
  it "does stuff in the controller", :vcr do
    #binding.pry
    start = "westminster, co"
    destination = "parker, co"
    cuisine = 'mexican'
    departure_time = Time.new(2022, 4, 25, 15, 5, 5)
    get "/api/v1/munchies?start=#{start}&destination=#{destination}&food=#{cuisine}"
    data = JSON.parse(response.body, symbolize_names: true)
    #binding.pry
    expect(response.status).to eq(200)
    expect(data[:data]).to have_key(:id)
    expect(data[:data]).to have_key(:type)
    expect(data[:data]).to have_key(:attributes)
    expect(data[:data][:attributes]).to have_key(:destination_city)
    expect(data[:data][:attributes]).to have_key(:travel_time)
    expect(data[:data][:attributes]).to have_key(:forecast)
    expect(data[:data][:attributes]).to have_key(:restaurant)
    expect(data[:data][:attributes][:forecast]).to have_key(:temperature)
    expect(data[:data][:attributes][:forecast]).to have_key(:summary)
    expect(data[:data][:attributes][:restaurant]).to have_key(:address)
  end
end
