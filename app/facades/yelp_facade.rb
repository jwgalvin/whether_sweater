class YelpFacade
  class << self
    def get_cuisine(cuisine, time, location)
      data = YelpService.yelp_search(cuisine, time, location)
      #poro = goes here if I have time
    end
  end
end
