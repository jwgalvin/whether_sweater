require 'rails_helper'

RSpec.describe YelpFacade do
  it 'does facade things', :vcr do
    cuisine = "mexican"
    time = Time.new(2022, 4, 25, 15, 5, 5)
    location = "Denver"
    searched = YelpService.yelp_search(cuisine, time, location)
    expect(searched).to be_a(Hash)
    expect(searched[:businesses][0]).to have_key(:name)
    expect(searched[:businesses][0]).to have_key(:image_url)
    expect(searched[:businesses][0][:location]).to have_key(:address1)
    expect(searched[:businesses][0][:location]).to have_key(:address2)
    expect(searched[:businesses][0][:location]).to have_key(:city)
    expect(searched[:businesses][0][:location]).to have_key(:state)
    expect(searched[:businesses][0][:location]).to have_key(:zip_code)
  end
end
