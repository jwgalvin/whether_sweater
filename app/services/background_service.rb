class BackgroundService
  class << self
    def img_search(search)
      response = conn.get('/v1/search') do |f|
        f.params['query'] = search
        f.headers['Authorization'] = ENV['background_key']
      end
      parse_data(response)
    end


    def conn
      Faraday.new(url: "https://api.pexels.com")
    end

    def parse_data(response)
      #binding.pry
      data = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
