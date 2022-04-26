class Api::V1::RoadTripController < ApplicationController

  def create
    #binding.pry
    user = User.find_by(api_key: params[:api_key])
    if user.present?
      road_trip = RoadTripFacade.create_trip(params[:origin],params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { status: 401, message: "Naughty Naughty, invalid key"}, status: 401
    end
  end
end
