require 'rails_helper'

RSpec.describe YelpService do
  it 'has a response', :vcr do
    response = YelpService.conn
    expect(response).to be_a(Faraday::Connection)
  end

  it 'gets a reponse with data I need', :vcr do

    response = YelpService.yelp_search('mexican', Time.now.to_i, "denver")
    binding.pry
    expect(response).to be_a(Hash)
    expect(response.count).to eq(3)
    expect(response).to have_key(:businesses)
    expect(response).to have_key(:region)
    expect(response).to have_key(:total)
  end
end
