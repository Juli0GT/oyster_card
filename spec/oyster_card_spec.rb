require './lib/oystercard.rb'
require './lib/station.rb'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:new_journey) {double :new_journey}
  let(:journey) {double :journey}
  # let{:journey2} {Journey.new}

  it 'has a balance of zero' do
    expect(oystercard.balance).to eq 0
  end

  it 'has no journeys' do
    expect(oystercard.journeys).to be_empty
  end

  xit 'checks that touch-in and touch out creates a journey' do
    oystercard.top_up(20)
    oystercard.touch_in(entry_station)
    oystercard.touch_out(exit_station)
    expect(oystercard.journeys).to include journey
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

  # describe '#in_journey' do
  #   it 'responds to in journey method' do
  #     expect(oystercard).to respond_to(:in_journey?)
  #   end
  # end

  describe '#touch_in' do
    it 'raise an error when touch in and the balance is lower than minimum' do
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Insufficient balance to touch in"
    end

    it 'starts the new journey' do
        oystercard.top_up(20)
        oystercard.touch_in(Station.new)
        expect(oystercard.journey).to eq({entry_station:"Bank", entry_zone: 1, exit_station: nil, exit_zone: nil })
      end
    end

  describe '#touch_out' do
    before do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
    end

    it 'completes in journey at touch out' do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end

    it 'forgets the entry station after the touch out' do
      oystercard.touch_out(exit_station)
      expect(oystercard.entry_station).to eq nil
    end

    it 'deducts a fare' do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Oystercard::MINIMUM_BALANCE)
    end
  end
end
