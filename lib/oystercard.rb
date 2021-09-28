class Oystercard
  MAX_BALANCE = 90
  MINIMUM_FARE = 1
  INSUFFICIENT_ERROR_MSG = "You have insufficient funds in your account!"
  attr_reader :balance, :entry_station


  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    below_limit?(amount) ? @balance += amount : raise("Over £#{MAX_BALANCE} balance limit!")
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    balance_above_0?(MINIMUM_FARE) ? @entry_station = entry_station : raise(INSUFFICIENT_ERROR_MSG)
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  private

  def below_limit?(amount)
    (@balance + amount) < MAX_BALANCE
  end

  def balance_above_0?(amount)
    (@balance - amount) > 0
  end

  def deduct(amount)
    balance_above_0?(amount) ? @balance -= amount : raise(INSUFFICIENT_ERROR_MSG)
  end

end