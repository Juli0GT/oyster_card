require_relative 'oystercard'
require_relative 'station'

MINIMUM_FARE = 1
PENALTY_FARE = 6

class Journey

  attr_reader :journey

  # def initialize
  #   @journey = {entry_station: nil, entry_zone: nil, exit_station: nil, exit_zone: nil }
  # end

  def start(station)
    @journey = {entry_station: nil, entry_zone: nil, exit_station: nil, exit_zone: nil }
    @journey[:entry_station] = station.name
    @journey[:entry_zone] = station.zone
  end

  def finish(station)
    @journey[:exit_station] = station.name
    @journey[:exit_zone] = station.zone
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
