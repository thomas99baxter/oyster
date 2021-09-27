class Oystercard
  MAX_BALANCE = 90
  attr_reader :balance
  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    total_balance = @balance + amount
    total_balance < MAX_BALANCE ? @balance += amount : raise("Over £#{MAX_BALANCE} balance limit!")
  end
end