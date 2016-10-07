class JourneyLogger
  attr_reader :journey_logger, :journey
  # attr_accessor :journey

  def initialize
    @journey_logger = []
  end

  def record_journey(journey)
    @journey_logger << journey
  end

  def history
    @journey_logger
  end
end
