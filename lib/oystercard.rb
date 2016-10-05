class Oystercard
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
attr_reader :balance, :limit, :in_journey, :minimum, :entry_station, :journeys

  def initialize(limit=MAXIMUM_LIMIT, minimum=MINIMUM_BALANCE)
    @limit = limit
    @minimum = minimum
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise 'Cannot top up over £90!' if @balance + amount >= @limit
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(entry_station)
    raise "Insufficient balance to touch in" if @balance < @minimum
    @exit_station = nil
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(@minimum)
    @exit_station = exit_station
    @journeys << {:entry_station => entry_station, :exit_station => exit_station}
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
