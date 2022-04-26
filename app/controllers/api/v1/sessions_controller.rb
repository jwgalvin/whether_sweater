class Api::V1::SessionsController < ApplicationController

  def create
    #binding.pry
    params[:user] = JSON.parse(request.raw_post)
    user = User.find_by(email: params[:email])
    if user.present? && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json:UserSerializer.new(user), status: :created
    else
      render json: {data: {message: "invalid credentials"}}, status: :bad_request
    end
  end

end
