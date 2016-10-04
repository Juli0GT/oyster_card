class Oystercard
MAXIMUM_LIMIT = 90
attr_reader :balance, :limit, :in_journey

  def initialize(limit=MAXIMUM_LIMIT)
    @limit = limit
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise 'Cannot top up over £90!' if @balance + amount >= @limit
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
