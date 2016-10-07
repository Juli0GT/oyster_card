require_relative 'oystercard'
require_relative 'station'

MINIMUM_FARE = 1
PENALTY_FARE = 6

class Journey

  attr_reader :journey

  def initialize
    @journey = {entry_station: nil, entry_zone: nil, exit_station: nil, exit_zone: nil }
  end

  def start(station)
    @journey[:entry_station] = station.name
    @journey[:entry_zone] = station.zone
  end

  def finish(station)
    @journey[:exit_station] = station.name
    @journey[:exit_zone] = station.zone
  end

  def fare
    complete_journey? ? MINIMUM_FARE : PENALTY_FARE
  end

  def complete_journey?
    !(@journey[:entry_station] && @journey[:exit_station]).nil?
  end
end
