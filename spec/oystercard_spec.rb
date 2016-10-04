require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe "#balance" do

    it "expects a default balance of 0" do
      expect(oystercard.balance).to eq Oystercard::DEFAULT_BALANCE
    end

    it "expects a different balance value than the default value" do
      oyster = Oystercard.new(20)
      expect(oyster.balance).to eq 20
    end
  end

  describe "#top_up" do

    it "allows the card to top-up certain amount" do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

    it "expects the balance to increase by top-up amount" do
      expect{oystercard.top_up(16)}.to change {subject.balance}.by 16
    end

    it "sets limit for oyster at 90" do
      expect(oystercard.balance).to be <= oystercard.limit
    end

    it "raises an error if balance is more than 90" do
      expect{oystercard.top_up(100)}.to raise_error "Cannot top-up more than 90"
    end
  end
end
