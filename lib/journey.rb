require_relative 'oystercard'

MINIMUM_FARE = 1
PENALTY_FARE = 6

class Journey

  attr_reader :entry_station

  def initialize(entry_station = @entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def finish
  end

  def fare
    if entry_station == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

  def complete
  end

end
