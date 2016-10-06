require 'station'
require 'journey'

class Oystercard
MAXIMUM_LIMIT = 90
MINIMUM_BALANCE = 1
PENALTY_FARE = 6
BALANCE = 0
attr_reader :balance, :limit, :in_journey, :minimum, :entry_station, :journeys, :new_journey

  def initialize(balance: BALANCE, journey: Journey)
    @limit = MAXIMUM_LIMIT
    @minimum = MINIMUM_BALANCE
    @balance = balance
    @journey_class
    @current_journey = nil
    @journeys = []
  end

  def top_up(amount)
    raise 'Cannot top up over £90!' if @balance + amount >= MAXIMUM_LIMIT
    @balance += amount
  end

  # def in_journey?
  #   !!entry_station
  # end

  def touch_in(entry_station)
    check_balance
  end

  def touch_out(exit_station)
    deduct(@minimum)
    @journeys << {:entry_station => entry_station, :exit_station => exit_station }
    @entry_station = nil
    @new_journey = nil
  end


  private

  def deduct(amount)
    @balance -= amount
  end

  def check_balance
    fail "Insufficient balance to touch in" if @balance < 1
  end
end
