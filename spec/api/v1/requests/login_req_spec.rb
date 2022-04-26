require 'rails_helper'

RSpec.describe "login" do
  it "handles a login request", :vcr do
    bob = User.create!(email: "bob@gmail.com", password: "12345", password_confirmation: "12345")
    user_params = {
      "email": "bob@gmail.com",
      "password": "12345",
    }
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post '/api/v1/sessions', headers: headers, params: user_params.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(parsed_data[:data]).to have_key(:id)
    expect(parsed_data[:data]).to have_key(:type)
    expect(parsed_data[:data]).to have_key(:attributes)
    expect(parsed_data[:data][:attributes]).to have_key(:email)
    expect(parsed_data[:data][:attributes]).to have_key(:api_key)
  end

  it "sad path- incorrect password", :vcr do
    bob = User.create!(email: "bob@gmail.com", password: "12345", password_confirmation: "12345")
    user_params = {
      "email": "bob@gmail.com",
      "password": "1235",
    }
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post '/api/v1/sessions', headers: headers, params: user_params.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    #binding.pry
    expect(response.status).to eq(400)
    expect(parsed_data[:data][:message]).to eq("invalid credentials")
  end

  it "sad path- incorrect email", :vcr do
    bob = User.create!(email: "bob@gmail.com", password: "12345", password_confirmation: "12345")
    user_params = {
      "email": "bob@gmails.com",
      "password": "12345",
    }
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post '/api/v1/sessions', headers: headers, params: user_params.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    #binding.pry
    expect(response.status).to eq(400)
    expect(parsed_data[:data][:message]).to eq("invalid credentials")
  end
end
