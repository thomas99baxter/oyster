# frozen_string_literal: true

require 'oystercard'
class Journey
  attr_reader :full_journey, :fare

  def initialize
    @full_journey = {
      entry_station: nil,
      exit_station: nil
    }
    @fare = 0
    @penalty = false
  end

  def start_journey(entry_station)
    @full_journey[:entry_station] = entry_station
  end

  def end_journey(exit_station)
    @full_journey[:exit_station] = exit_station
  end

  def add_to_fare(amount)
    @penalty = true if amount == Oystercard::PENALTY_FARE
    @fare += amount
  end

  def not_started?
    full_journey[:entry_station].nil?
  end

  def calculate_total_fare
    add_to_fare((@full_journey[:entry_station].zone - @full_journey[:exit_station].zone).abs) unless @penalty
    @fare
  end
end
