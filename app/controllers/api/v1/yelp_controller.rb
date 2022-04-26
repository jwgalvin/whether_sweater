class Api::V1::YelpController < ApplicationController

  def index
    @munchies = YelpFacade.get_munchies(params[:food], params[:start], params[:destination])
    render json: MunchySerializer.munchyizer(@munchies)
    #binding.pry
  end
end
