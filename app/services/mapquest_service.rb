class MapquestService
  class << self
    def routing(start_address, end_address)
      response = conn.get("/directions/v2/route?key=#{ENV['mapquest_key']}&from=#{start_address}&to=#{end_address}")
      parse_data(response)
    end

    def gps(location)
      response = conn.get("/geocoding/v1/address?location=#{location}")
      parse_data(response)
    end

    private
    def conn
      Faraday.new(url: "http://www.mapquestapi.com") do |fard|
       fard.params['key'] = ENV['mapquest_key']
      end
     end

    def parse_data(response)
      data = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
