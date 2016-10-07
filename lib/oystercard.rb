require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

class Oystercard
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
attr_reader :balance, :limit, :minimum, :station, :journeys, :journey, :in_use

  def initialize
    @balance = 0
    @in_use = false
    @journey_logger = JourneyLogger.new
  end

  def in_journey?
    @in_use
  end

  def top_up(amount)
    raise 'Cannot top up over £90!' if @balance + amount >= MAXIMUM_LIMIT
    @balance += amount
  end


  def touch_in(entry_station)
    raise "Insufficient balance to touch in" if @balance < MINIMUM_BALANCE
    journey_start(entry_station)
    @in_use = true
  end

  def touch_out(exit_station)
    @journey = Journey.new if @journey == nil
    record_journey(exit_station)
    @journey = nil
    @in_use = false
  end

  private


  def deduct(amount)
    @balance -= amount
  end

  def complete
    deduct(@journey.fare)
  end

  def journey_start(entry_station)
    if in_journey?
      complete
      @journey_logger.record_journey(@journey)
    end
      @journey = Journey.new
      @journey.start(entry_station)
      @journey_logger.record_journey(entry_station)
  end

  def record_journey(exit_station)
    @journey_logger.record_journey(@journey.finish(exit_station))
    complete
  end
end
