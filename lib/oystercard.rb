class Oystercard
  MAX_BALANCE = 90
  MINIMUM_FARE = 1
  INSUFFICIENT_ERROR_MSG = "You have insufficient funds in your account!"
  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    below_limit?(amount) ? @balance += amount : raise("Over £#{MAX_BALANCE} balance limit!")
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    balance_above_0?(MINIMUM_FARE) ? @in_journey = true : raise(INSUFFICIENT_ERROR_MSG)
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
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