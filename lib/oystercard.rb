class Oystercard
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance
  attr_reader :entry_station
  attr_reader :exit_station
  attr_reader :journeys
  def initialize
    @balance = 0
    @journey = false
    @entry_station = nil
    @journeys = {}
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
    @journeys[:entry_station] = station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = exit_station
    @journeys[:exit_station] = exit_station
    #if you need to store multiple journeys - try creating the hash here and then pushing into journey array
  end
end