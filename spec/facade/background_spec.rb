require 'rails_helper'

RSpec.describe BackgroundFacade do
  it 'has an image', :vcr do
    backdrop = BackgroundFacade.image_finder('denver, co')
    #binding.pry
    expect(backdrop[:photos][0]).to have_key(:photographer_url)
    expect(backdrop[:photos][0]).to have_key(:url)
    expect(backdrop[:photos][0]).to have_key(:photographer_id)
    expect(backdrop[:photos][0]).to have_key(:id)
  end
end
