class YelpService
  class << self
    def yelp_search(search, eta, location)
      time = eta.to_i
      response = conn.get("/v3/businesses/search?location=#{location}&open_at=#{time}&term=#{search}") do |f|
        f.headers['Authorization'] = ENV['yelp_key']
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
