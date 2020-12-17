class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0
    @journey = false
    @entry_station = nil
  end

  def top_up(amount)
    fail "top up balance of #{BALANCE_LIMIT} exceeded" if amount + @balance > BALANCE_LIMIT
    @balance += amount
  end

  def deduct(fare)
    @balance -= fare
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    fail "insufficient funds" if balance < MINIMUM_FARE
    in_journey?
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end
end