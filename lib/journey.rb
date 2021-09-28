# TOM: i dont want to have anything, within the init, that will 
# raise an error, i think it'd be better to do a bigger refactor and split between
# the classes (SRP / granularisation)

# TROY: I want to raise an error in the oystercard class for handling penalties. 
# if !in_journey?
#   @new_journey = Journey.new(entry_station)
# else
#   raise "You have not touched out"
# It only interacts with the journey class on valid trips (e.g. only called when checks have already been made)

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