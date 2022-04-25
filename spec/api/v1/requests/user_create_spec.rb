require 'rails_helper'

RSpec.describe "UsersController" do
  it "creates a new user", :vcr do
    user_params = {
      "email": "me@email.com",
      "password": "12345",
      "password_confirmation": "12345"
    }
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post '/api/v1/users', headers: headers, params: user_params.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)

    expect(response.status).to eq(201)
    expect(parsed_data[:data]).to have_key(:id)
    expect(parsed_data[:data]).to have_key(:type)
    expect(parsed_data[:data]).to have_key(:attributes)
    expect(parsed_data[:data][:attributes]).to have_key(:email)
    expect(parsed_data[:data][:attributes]).to have_key(:api_key)
  end

  it "sad paths no email provided" do
    user_params = {

      "password": "12345",
      "password_confirmation": "12345"
    }
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post '/api/v1/users', headers: headers, params: user_params.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_data[:status]).to eq(400)
    expect(parsed_data[:message]).to eq("Email can't be blank")
  end

  it "sad paths no pw provided" do
    user_params = {
      "email": "me@email.com",

      "password_confirmation": "12345"
    }
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post '/api/v1/users', headers: headers, params: user_params.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    expect(parsed_data[:status]).to eq(400)
    expect(parsed_data[:message]).to eq("Password digest can't be blank and Password can't be blank")
  end

  it "sad paths no pw or pw-c provided" do
    user_params = {
      "email": "me@email.com"
    }
    headers = {
      'Content-Type' => 'application/json',
      'Accept' => 'application/json'
    }

    post '/api/v1/users', headers: headers, params: user_params.to_json
    parsed_data = JSON.parse(response.body, symbolize_names: true)
    binding.pry
    expect(parsed_data[:status]).to eq(400)
    expect(parsed_data[:message]).to eq("Password digest can't be blank and Password can't be blank")
  end
end
