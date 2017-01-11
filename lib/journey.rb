require_relative 'oystercard'

class Journey

  MIN_FARE = 1
  PENALTY = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @complete = false
  end

  def finish_journey(exit_station = "No touch out")
    @exit_station = exit_station
    @complete = true
  end

  def fare(penalty)
  penalty ? PENALTY : MIN_FARE 
  end

  def complete?
    @complete
  end

end
