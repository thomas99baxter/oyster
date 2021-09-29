class JourneyLog
  attr_reader :journeys
  def initialize
    @journeys = []
  end

  def add_journey(journey)
    @journeys << journey
  end

end