require 'rails_helper'

RSpec.describe "YelpController" do
  it "does stuff in the controller", :vcr do
    #binding.pry
    start = "westminster, co"
    destination = "parker, co"
    cuisine = 'mexican'
    get "/api/v1/munchies?start=#{start}&destination=#{destination}&food=#{cuisine}"

    trip = MapquestFacade.route(start, destination)
    yelp_search = YelpFacade.get_cuisine(cuisine, eta, destination)
    binding.pry
  end
end
