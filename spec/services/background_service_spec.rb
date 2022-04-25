require 'rails_helper'

RSpec.describe 'Pexel background Service' do
  it 'has a response', :vcr do
    test = BackgroundService.conn
    expect(test).to be_a(Faraday::Connection)
  end

  it "gets a picture for me", :vcr do
    response =  BackgroundService.img_search('denver, co')
    #binding.pry
    expect(response).to be_a(Hash)
    expect(response.count).to eq(5)
    expect(response).to have_key(:photos)
    expect(response).to have_key(:page)
    expect(response).to have_key(:per_page)
  end
end
