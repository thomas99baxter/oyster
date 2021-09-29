require 'journey'

class Oystercard
  MAX_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  INSUFFICIENT_ERROR_MSG = "You have insufficient funds in your account!"
  attr_reader :balance, :journeys, :new_journey


  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    below_limit?(amount) ? @balance += amount : raise("Over £#{MAX_BALANCE} balance limit!")
  end

  def attempt_touch_in(entry_station)
    @new_journey.add_to_fare(PENALTY_FARE) if !journey_not_started?
    touch_in(entry_station)
  end
  

  def attempt_touch_out(exit_station)
    # @new_journey.add_to_fare(PENALTY_FARE) if journey_not_started?
    touch_out(exit_station) 
  end

  private

  def journey_not_started? 
    @new_journey.nil? 
  end
  
  def touch_in(entry_station)
    balance_above_0?(MINIMUM_FARE) ? @new_journey = Journey.new(entry_station) : raise(INSUFFICIENT_ERROR_MSG)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
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
    @new_journey.end_journey(exit_station)
    @journeys.push(@new_journey)
    @new_journey = nil
  end

end