require 'journey'
require 'oystercard'
require 'station'

describe Journey do
  subject(:journey) {described_class.new}
  let(:oystercard) {double :oystercard}
  let(:station1) {Station.new("Bank", 1)}
  let(:station2) {Station.new("Waterloo", 1)}


  describe '#start_journey' do
   it 'starts a new journey' do
     journey.start(station1)
     expect(journey.journey).to eq({entry_station:"Bank", entry_zone: 1, exit_station: nil, exit_zone: nil })
   end
  end

  describe '#finish_journey' do
    it 'finishes the journey' do
      journey.start(station1)
      journey.finish(station2)
      expect(journey.journey).to eq({entry_station:"Bank", entry_zone: 1, exit_station: "Waterloo", exit_zone: 1 })
    end
  end

  describe '#journey_fare' do
    it 'calculates the fare of the journey' do
      expect(journey).to respond_to(:fare)
    end
  end

  describe '#journey_complete' do
    it 'completes the journey' do
      expect(journey).to respond_to(:complete)
    end
  end
end
