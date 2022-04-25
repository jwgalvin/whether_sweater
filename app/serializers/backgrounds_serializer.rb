class BackgroundsSerializer
  class << self
    def one_image(backdrop, location)
      #binding.pry
      { "data":
        {
          "id": nil,
          "type": 'image',
          "attributes":
          {
            "image":
            {
              "location": location,
              "image_url": backdrop[:photos][0][:url]
            },
            "credit":
            {
              "source": backdrop[:photos][0][:photographer_url],
              "author": backdrop[:photos][0][:photographer],
              "logo": backdrop[:photos][0][:src][:small]
            }
          }
        }
      }
    end
  end
end
