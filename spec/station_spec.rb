require 'station'

describe Station do
  subject(:station) {described_class.new("Bank", 1)}


  it 'initalizes with station name' do
    expect(station.name).to eq("Bank")
  end

  it 'intitalizes with zone number' do
    expect(station.zone).to eq(1)
  end

end
