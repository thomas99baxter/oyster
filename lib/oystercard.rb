require 'journey'
require 'journey_log'

class Oystercard
  MAX_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  INSUFFICIENT_ERROR_MSG = "You have insufficient funds in your account!"
  attr_reader :balance, :journey_log, :new_journey


  def initialize(balance = 0)
    @balance = balance
    @journey_log = JourneyLog.new
    # TODO - get rid of having to initialize this journey
    @new_journey = Journey.new
  end

  def top_up(amount)
    below_limit?(amount) ? @balance += amount : raise("Over £#{MAX_BALANCE} balance limit!")
  end

  def attempt_touch_in(entry_station)
    @new_journey = Journey.new
    @new_journey.add_to_fare(PENALTY_FARE) if !@new_journey.not_started?
    touch_in(entry_station)
  end
  

  def attempt_touch_out(exit_station)
    @new_journey.not_started? ? @new_journey.add_to_fare(PENALTY_FARE) : @new_journey.add_to_fare(MINIMUM_FARE)
    touch_out(exit_station)
  end

  private
  
  def touch_in(entry_station)
    balance_above_0?(MINIMUM_FARE) ? @new_journey.start_journey(entry_station) : raise(INSUFFICIENT_ERROR_MSG)
  end

  def touch_out(exit_station)
    @new_journey.end_journey(exit_station)
    deduct(@new_journey.calculate_total_fare)
    reset_journey(exit_station)
  end

  def below_limit?(amount)
    (@balance + amount) < MAX_BALANCE
  end
  
  def balance_above_0?(amount)
    (@balance - amount) > 0
  end
  
  def deduct(amount)
    balance_above_0?(amount) ? @balance -= amount : raise(INSUFFICIENT_ERROR_MSG)
  end

  def reset_journey(exit_station)
    @journey_log.add_journey(@new_journey)
  end

end