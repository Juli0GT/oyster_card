require './lib/oystercard.rb'
require './lib/station.rb'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) {double :station, :name => 'Bank', :zone => 2}
  let(:exit_station) {double :station, name: "Waterloo", zone: 1}
  let(:new_journey) {double :new_journey}

  it 'has a balance of zero' do
    expect(oystercard.balance).to eq 0
  end

  it 'has no journeys' do
    expect(oystercard.journeys).to be_empty
  end

  it 'checks that touch-in and touch out creates a journey' do
    oystercard.top_up(20)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journeys[0].journey).to include({entry_station: "Bank", entry_zone: 2, exit_station: "Waterloo", exit_zone: 1})
  end

  describe "#top_up" do

    it 'adds to balance' do
      expect{ oystercard.top_up(1) }.to change {oystercard.balance}.by 1
    end
    it 'limits balance' do
      expect(oystercard.balance).to be <= oystercard.limit
    end
    it 'raises an error when balance limit is exceeded' do
      expect{oystercard.top_up(91)}.to raise_error 'Cannot top up over £90!'
    end
  end

  describe '#touch_in' do
    it 'raise an error when touch in and the balance is lower than minimum' do
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Insufficient balance to touch in"
    end

    it 'deducts penalty fare if touch in twice' do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
      expect{oystercard.touch_in(entry_station)}.to change{oystercard.balance}.by(-Oystercard::PENALTY_FARE)
    end
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
    end

    it 'deducts a fare' do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'deducts a penalty fare if touch ou twice' do
      oystercard.touch_out(exit_station)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Oystercard::PENALTY_FARE)
    end
  end
end
