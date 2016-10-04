class Oystercard
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
attr_reader :balance, :limit, :in_journey, :minimum

  def initialize(limit=MAXIMUM_LIMIT, minimum=MINIMUM_BALANCE)
    @limit = limit
    @minimum = minimum
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise 'Cannot top up over £90!' if @balance + amount >= @limit
    @balance += amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Insufficient balance to touch in" if @balance < @minimum
    @in_journey = true
  end

  def touch_out
    deduct(@minimum)
    @in_journey = false
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
