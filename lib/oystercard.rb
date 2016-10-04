class Oystercard
MAXIMUM_LIMIT = 90
attr_reader :balance, :limit

  def initialize(limit=MAXIMUM_LIMIT)
    @limit = limit
    @balance = 0
  end

  def top_up(amount)
    raise 'Cannot top up over £90!' if @balance + amount >= @limit
    @balance += amount
  end
end
