# frozen_string_literal: true
# mainly feature tests and custom error classes in here
require 'custom_errors'
require 'journey'
require 'journey_log'

class Oystercard
  MAX_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  # can we refactor this to use special error classes i.e InsufficientFundsError?
  attr_reader :balance, :journey_log, :new_journey

  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new
    # TODO: - get rid of having to initialize this journey AND can a user take multiple journeys without things going tits up? 
    # Yes to the above, but only fails on one test. dont like initalising journey twice.
    @new_journey = Journey.new
  end

  def top_up(amount)
    below_limit?(amount) ? @balance += amount : raise(OverMaxBalanceError.new())
  end

  def attempt_touch_in(entry_station)
    @new_journey = Journey.new
    @new_journey.add_to_fare(PENALTY_FARE) unless @new_journey.not_started?
    touch_in(entry_station)
  end

  def attempt_touch_out(exit_station)
    # do some more testing on how this affects final fare - is this 'really' covered?
    @new_journey.not_started? ? @new_journey.add_to_fare(PENALTY_FARE) : @new_journey.add_to_fare(MINIMUM_FARE)
    touch_out(exit_station)
  end

  private

  def touch_in(entry_station)
    balance_above_0?(MINIMUM_FARE) ? @new_journey.start_journey(entry_station) : raise(InsufficientFundsError.new())
  end

  def touch_out(exit_station)
    @new_journey.end_journey(exit_station)
    deduct(@new_journey.calculate_total_fare)
    @journey_log.add_journey(@new_journey)
  end

  def below_limit?(amount)
    (@balance + amount) < MAX_BALANCE
  end

  def balance_above_0?(amount)
    (@balance - amount).positive?
  end

  def deduct(amount)
    # custom error classes again.
    balance_above_0?(amount) ? @balance -= amount : raise(InsufficientFundsError.new())
  end
end
