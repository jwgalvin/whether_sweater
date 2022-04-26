class Route
  attr_reader :distance, :eta, :parsed_directions

  def initialize(data)
    @distance = data[:distance]
    @eta = data[:formattedTime]
    @maneuvers = check_directions(data)
    @parsed_directions = parse_directions
  end

  def check_directions(data)
    if data[:routeError][:errorCode] == 2
      return "Not a Valid Route, May need to book a flight or cabin."
    else
      return data[:legs][0][:maneuvers]
    end
  end

  def parse_directions
    if @maneuvers == "Not a Valid Route, May need to book a flight or cabin."
      return @maneuvers
    else
      route = @maneuvers.map { |direction| direction[:narrative]}
    end
  end
end
