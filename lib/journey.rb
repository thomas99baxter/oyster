require 'oystercard'
class Journey
  MINIMUM_FARE = 1
  attr_reader :full_journey, :fare
  def initialize(entry_station)
    @full_journey = {
       :entry_station => entry_station,
       :exit_station => nil
    }
    @fare = 0
  end

  def end_journey(exit_station)
    @full_journey[:exit_station] = exit_station
  end
  
  def add_to_fare(amount)
    @fare += amount
  end

end