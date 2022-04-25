class MunchySerializer
  def self.munchyizer(array)
    #binding.pry
      {
      "data": {
        "id": "null",
        "type": "munchie",
        "attributes": {
          "destination_city": "#{array[1][:businesses][0][:location][:city]}, #{array[1][:businesses][0][:location][:state]} ",
          "travel_time":" #{array[0].eta}",
          "forecast": {
            "summary": "Cloudy with a chance of meatballs",
            "temperature": "83"
          },
          "restaurant": {
            "name": "#{array[1][:businesses][0][:name]}",
            "address": "#{array[1][:businesses][0][:location][:address1]} #{array[1][:businesses][0][:location][:address2]}, #{array[1][:businesses][0][:location][:city]}, #{array[1][:businesses][0][:location][:state]}#{array[1][:businesses][0][:location][:zip_code]}"
          }
        }
      }
    }
  end
end
