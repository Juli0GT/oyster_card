require_relative 'journey'
require_relative 'station'

class Oystercard
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
attr_reader :balance, :limit, :minimum, :station, :journeys, :journey

  def initialize
    @limit = MAXIMUM_LIMIT
    @minimum = MINIMUM_BALANCE
    @balance = 0
    @journey = Journey.new
    @journeys = []
    #@station = Station.new
  end

  def top_up(amount)
    raise 'Cannot top up over £90!' if @balance + amount >= MAXIMUM_LIMIT
    @balance += amount
  end

  # def in_journey?
  #   !!entry_station
  # end

  def touch_in(entry_station)
    raise "Insufficient balance to touch in" if @balance < @minimum
    @journey.start(entry_station)
  end

  def touch_out(exit_station)
    deduct(@minimum)
    # @journeys << {:entry_station => entry_station, :exit_station => exit_station }
    @journey.finish(exit_station)
  end

  private


  def deduct(amount)
    @balance -= amount
  end
end
