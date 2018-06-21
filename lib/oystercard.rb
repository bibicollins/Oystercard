class Oystercard
  attr_reader :balance, :in_journey, :entry_station, :exit_station, :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if over_limit?(amount)
    @balance += amount
  end



  def touch_in(station)
    raise "Insufficient balance to touch in" if low_balance?
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    @exit_station = station
    @journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
    @entry_station = nil
    @exit_station = nil
  end

  def low_balance?
    balance < MINIMUM_BALANCE
  end

  def over_limit?(amount)
    amount + @balance > MAXIMUM_BALANCE
  end

 private

  def deduct(amount)
    @balance -= amount
  end
end
