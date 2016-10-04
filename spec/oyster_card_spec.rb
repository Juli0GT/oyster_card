require './lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) {described_class.new}
  it 'has a balance of zero' do
    expect(oystercard.balance).to eq 0
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
    it 'raises an error when oystercard is full' do
      expect{oystercard.top_up(91)}.to raise_error 'Cannot top up over £90!'
    end
  end

  describe '#deduct' do
    it 'responds to deduct method' do
      expect(oystercard).to respond_to(:deduct).with(1).argument
    end
    it 'deducts an amount from balance' do
      expect{ oystercard.deduct(1) }.to change {oystercard.balance}.by -1
    end
  end
end
