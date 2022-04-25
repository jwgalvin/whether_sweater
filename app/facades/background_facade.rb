class BackgroundFacade
  class << self
    def image_finder(strings)
      variable_name = BackgroundService.img_search(strings)
      #binding.pry
      #Backdrop.new(variable_name)
    end
  end
end
