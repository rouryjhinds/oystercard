class Oystercard
  BALANCE_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail 'top up balance exceeded' if @balance >= BALANCE_LIMIT
    @balance += amount
  end
end