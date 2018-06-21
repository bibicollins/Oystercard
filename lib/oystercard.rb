require 'journey'
class Oystercard
  attr_reader :balance, :journeys, :current_journey
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = Journey::MINIMUM_FARE

  def initialize
    @balance = 0
    @journeys = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Maximum balance of #{MAXIMUM_BALANCE} exceeded" if over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient balance to touch in" if low_balance?
    @current_journey = Journey.new(station)
  end

  def touch_out(station)
    @current_journey = Journey.new(nil) unless @current_journey
    deduct(@current_journey.calculate_fare)
    @current_journey.complete(station)
    store_journey
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

  def store_journey
    @journeys << @current_journey
    @current_journey = nil
  end
end
