class YelpFacade
  class << self
    def get_cuisine(cuisine, eta, location)
      data = YelpService.yelp_search(cuisine, eta, location)
      #poro = poro.new(data)goes here if I have time
    end
  end
end
