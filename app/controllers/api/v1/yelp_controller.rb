class Api::V1::YelpController < ApplicationController

  def index
    trip = MapquestFacade.route(params[:start], params[:destination])
    arrival = eta_to_expected(trip.eta)
    #binding.pry
    yelp_search = YelpFacade.get_cuisine(params[:food], arrival, params[:destination])
    #render json:
  end


  private
  def eta_to_expected(eta)
    arrival_time = Time.now.to_i + eta.to_i
  end
end
