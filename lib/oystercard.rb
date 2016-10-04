class Oystercard
  attr_reader :balance, :limit
  DEFAULT_BALANCE = 0
  BALANCE_LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @limit = BALANCE_LIMIT
  end

  def top_up(amount)
    fail "Cannot top-up more than 90" if (@balance + amount) > @limit
    @balance += amount
  end

end

# private
# attr_reader :balance
