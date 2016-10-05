require 'station'

describe Station do
  subject(:station) {described_class.new(name: "Old Street", zone: 1)}


  it 'initalizes with station name' do
    expect(station.name).to eq("Old Street")
  end

  it 'intitalizes with zone number' do
    expect(station.zone).to eq(1)
  end

end
