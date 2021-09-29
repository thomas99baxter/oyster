require 'oystercard'
class Journey
  MINIMUM_FARE = 1
  attr_reader :full_journey, :fare
  def initialize
    @full_journey = {
       :entry_station => nil,
       :exit_station => nil
    }
    @fare = 0
  end

  def start_journey(entry_station)
    @full_journey[:entry_station] = entry_station
  end

  def end_journey(exit_station)
    @full_journey[:exit_station] = exit_station
  end
  
  def add_to_fare(amount)
    @fare += amount
  end

  def not_started? 
    self.full_journey[:entry_station].nil?
  end

end