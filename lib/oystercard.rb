require_relative 'journey'
class Oystercard
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
attr_reader :balance, :limit, :in_journey, :minimum, :entry_station, :journeys, :new_journey

  def initialize(limit=MAXIMUM_LIMIT, minimum=MINIMUM_BALANCE)
    @limit = limit
    @minimum = minimum
    @balance = 0
    @journeys = []
    @new_journey = nil
  end

  def top_up(amount)
    raise 'Cannot top up over £90!' if @balance + amount >= MAXIMUM_LIMIT
    @balance += amount
  end

  def in_journey?
    !!entry_station
  end

  def touch_in(entry_station)
    raise "Insufficient balance to touch in" if @balance < @minimum
    # clear_single_journey
    check_journey_can_start
    #@new_journey[:entry]
    # @entry_station = entry_station
    #@new_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(@minimum)
    @journeys << {:entry_station => entry_station, :exit_station => exit_station }
    @entry_station = nil
    @new_journey = nil
  end

  # def clear_single_journey
  #   @new_journey = {entry_station: nil, entry_zone: nil, exit_station: nil, exit_zone: nil}
  # end

  private

  def check_journey_can_start
    if @new_journey = nil
      @new_journey = Journey.new(entry_station)
    else
      @new_journey.finish_journey(nil)
    end
  end

  def deduct(amount)
    @balance -= amount
  end
end
