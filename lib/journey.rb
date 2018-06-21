class Journey
def initialize(entry_station = nil)
@entry_station = entry_station


  def in_journey?
    !!@entry_station
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
end
