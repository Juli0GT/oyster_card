require './lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) {double :entry_station}
  let(:exit_station) {double :exit_station}
  it 'has a balance of zero' do
    expect(oystercard.balance).to eq 0
  end

  it 'has no journeys' do
    expect(oystercard.journeys).to eq []
  end

  it 'checks that touch-in and touch out creates a journey' do
    oystercard.top_up(20)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journeys).to eq  [{:entry_station => entry_station, :exit_station => exit_station}]
  end

  describe "#top_up" do
    before do
      @balance = 0
    end
    it 'respond to top up method' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end
    it 'adds to balance' do
      expect{ oystercard.top_up(1) }.to change {oystercard.balance}.by 1
    end
    it 'limits balance' do
      expect(oystercard.balance).to be <= oystercard.limit
    end
    it 'raises an error' do
      expect{oystercard.top_up(91)}.to raise_error 'Cannot top up over £90!'
    end
  end

  describe '#in_journey' do
    it 'responds to in journey method' do
      expect(oystercard).to respond_to(:in_journey?)
    end
    it 'is initially not in journey' do
      expect(oystercard).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'responds to touch in method' do
      expect(oystercard).to respond_to(:touch_in).with(1).argument
    end

    it 'can touch in' do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

    it 'raise an error when touch in and the balance is lower than minimum' do
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Insufficient balance to touch in"
    end

    it 'remembers the entry station after the touch in' do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
      expect(oystercard.touch_in(entry_station)).to eq(entry_station)
    end
  end

  describe '#touch_out' do
    before do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
    end

    it 'can touch out' do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'deducts a fare' do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end
  end
end
