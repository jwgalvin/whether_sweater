class Api::V1::YelpController < ApplicationController

  def index
    #binding.pry
    @munchies = YelpFacade.get_munchies(params[:food], params[:start], params[:destination])
    render json: MunchySerializer.munchyizer(@munchies)
    #binding.pry
  end

  def eta_to_expected(departure_time, travel_time)
    arrival_time = departure_time.to_i + travel_time.to_i
  end
end
