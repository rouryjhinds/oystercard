class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @journey = false
  end

  def top_up(amount)
    fail "top up balance of #{BALANCE_LIMIT} exceeded" if amount + @balance > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    @journey
  end

  def touch_in
    fail "insufficient funds" if balance < MINIMUM_FARE
    @journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @journey = false
  end
end