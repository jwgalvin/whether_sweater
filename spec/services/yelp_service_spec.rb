require 'rails_helper'

RSpec.describe YelpService do
  it 'has a response', :vcr do
    response = YelpService.conn
    expect(response).to be_a(Faraday::Connection)
  end

  it 'gets a reponse with data I need', :vcr do

    response = YelpService.yelp_search('fast food', Time.now.to_i, "denver")
    binding.pry
    expect(response).to be_a(Hash)
    expect(response.count).to eq(5)
    expect(response).to have_key(:photos)
    expect(response).to have_key(:page)
    expect(response).to have_key(:per_page)
  end
end
