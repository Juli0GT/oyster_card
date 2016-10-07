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
    complete_journey? ?  zone_fare : PENALTY_FARE
  end

  def complete_journey?
    !(@journey[:entry_station] && @journey[:exit_station]).nil?
  end

  def zone_fare
    ((@journey[:exit_zone] - @journey[:entry_zone]).abs + 1)
  end
end
