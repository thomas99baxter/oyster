# TOM: i dont want to have anything, within the init, that will 
# raise an error, i think it'd be better to do a bigger refactor and split between
# the classes (SRP / granularisation)

# TROY: 

require 'oystercard'
class Journey
  MINIMUM_FARE = 1
  attr_reader :full_journey
  def initialize(entry_station)
    @full_journey = {
       :entry_station => entry_station,
       :exit_station => nil
    }
  end

  def end_journey(exit_station)
    @full_journey[:exit_station] = exit_station
  end
  
  def fare
    Oystercard::MINIMUM_FARE 
  end

  private

  def complete?
    !@full_journey.exit_station.nil?
  end
  
  def started?

  end
end