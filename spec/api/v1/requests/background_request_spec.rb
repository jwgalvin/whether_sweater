require 'rails_helper'

RSpec.describe 'requests an image for a backdrop', :vcr do
  it "returns a json with the image" do
    get '/api/v1/backgrounds?location=denver,co'
    #binding.pry

    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it "has the right format" do
    get '/api/v1/backgrounds?location=denver,co'
    backdrop = JSON.parse(response.body, symbolize_names: true)
    expect(backdrop).to have_key(:data)
    expect(backdrop[:data]).to have_key(:id)
    expect(backdrop[:data]).to have_key(:type)
    expect(backdrop[:data]).to have_key(:attributes)
    expect(backdrop[:data][:attributes]).to have_key(:image)
    expect(backdrop[:data][:attributes]).to have_key(:credit)
    expect(backdrop[:data][:attributes][:image]).to have_key(:location)
    expect(backdrop[:data][:attributes][:image]).to have_key(:image_url)
    expect(backdrop[:data][:attributes][:credit]).to have_key(:source)
    expect(backdrop[:data][:attributes][:credit]).to have_key(:author)
    expect(backdrop[:data][:attributes][:credit]).to have_key(:logo)

    expect(backdrop[:data][:attributes]).to_not have_key(:width)
    expect(backdrop[:data][:attributes]).to_not have_key(:height)
  end
  
  it 'returns 404 when invalid params are given', :vcr do

    headers = { 'CONTENT_TYPE' => 'application/json', "Accept" => 'application/json' }
    get '/api/v1/backgrounds', headers: headers, params: { photo: "ksdkjas" }
    expect(response).to_not be_successful
    expect(response.status).to eq(404)
  end
end
