class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_reader :exit_station, :entry_station
  def initialize(entry_station = nil)
    @entry_station = entry_station
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def complete(station)
    @in_journey = false
    @exit_station = station
  end

  def calculate_fare
    @entry_station && @exit_station ? MINIMUM_FARE : PENALTY_FARE
  end
end











  #attr_reader :entry_station, :exit_station
  #MINIMUM_FARE = 1
  #def initialize(station = nil)
#@entry_station = station
#  end
#  def complete_journey(station = nil)
#    @exit_station = station
#  end
