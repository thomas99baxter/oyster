class Journey
  attr_reader :full_journey
  def initialize(entry_station)
    # @entry_station = entry_station
    @full_journey = {
       :entry_station => entry_station,
       :exit_station => nil
    }
  end

  def end_journey(exit_station)
    @full_journey[:exit_station] = exit_station
  end
end