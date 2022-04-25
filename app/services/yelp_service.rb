class YelpService
  class << self
    def yelp_search(search)
      response = conn.get('/events/featured') do |f|
        #f.params['query'] = search
        f.headers['Authorization'] = ENV['yelp_key']
                #['Authorization: Bearer'] =
      end
      parse_data(response)
    end


    def conn
      Faraday.new(url: "https://api.yelp.com/v3")
    end

    def parse_data(response)
      #binding.pry
      data = JSON.parse(response.body, symbolize_names: true)
    end

  end
end
