require 'oystercard'
class OverMaxBalanceError < StandardError
  def initialize(msg="Over £#{Oystercard::MAX_BALANCE} balance limit!")
    super
  end
end

class InsufficientFundsError < StandardError
  def initialize(msg="You have insufficient funds in your account!")
    super
  end
end