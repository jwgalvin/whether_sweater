class Api::V1::BackgroundsController < ApplicationController
  before_action :confirm_geocode

  def index
    pic = BackgroundFacade.image_finder(@location)
    render json: BackgroundsSerializer.one_image(pic, @location)
  end

  private

  def confirm_geocode
    if params[:location].present?
      @location = params[:location]
    else
      render status: 404
    end
  end
end
