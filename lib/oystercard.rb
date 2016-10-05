class Oystercard
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
attr_reader :balance, :limit, :in_journey, :minimum, :entry_station

  def initialize(limit=MAXIMUM_LIMIT, minimum=MINIMUM_BALANCE)
    @limit = limit
    @minimum = minimum
    @balance = 0
    @entry_station = nil
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
    @entry_station = entry_station
    @exit_station = nil
  end

  def touch_out(exit_station)
    deduct(@minimum)
    @entry_station = nil
    @exit_station = exit_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
