require 'journey'
require 'oystercard'

describe Journey do
  subject(:journey) {described_class.new}
  let(:oystercard) {double :oystercard}


  describe '#finish_journey' do
    it 'finishes the journey' do
      expect(journey).to respond_to(:finish)
    end
  end

  describe '#journey_fare' do
    it 'calculates the fare of the journey' do
      expect(journey).to respond_to(:fare)
    end

    it 'returns penalty fare when entry_station is nil' do

    end
  end

  describe '#journey_complete' do
    it 'completes the journey' do
      expect(journey).to respond_to(:complete)
    end
  end
end
