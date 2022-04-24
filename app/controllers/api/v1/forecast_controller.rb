class Api::V1::ForecastController < ApplicationController

  def index
    city = MapquestFacade.geocode(params[:location])
    forecast = WeatherFacade.forecast(city)
    render json: WeatherSerializer.weather(forecast)
  end
end
