class YelpService
  class << self
    def yelp_search(search, eta, location)
      response = conn.get("/v3/businesses/search?location=#{location}&open_at=#{eta}&term=#{search}") do |f|
        f.headers['Authorization'] = ENV['yelp_key']
        # f.params['location'] = location
        # f.params['open_at'] = eta
        # f.params['term'] = search
      end
      parse_data(response)
    end


    def conn
      Faraday.new(url: "https://api.yelp.com")
    end

    def parse_data(response)
      #binding.pry
      data = JSON.parse(response.body, symbolize_names: true)
    end

  end
end
