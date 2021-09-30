# frozen_string_literal: true

require 'station'

describe Station do
  describe '#initialize' do
    it 'should initialize a class of station' do
      test_station = described_class.new("King's Cross", 1)
      expect(test_station.class).to eq(Station)
    end

    it 'should initizialize name and zone instance variables' do
      test_station = described_class.new("King's Cross", 1)

      expect(test_station).to have_attributes(name: "King's Cross", zone: 1)
    end
  end
end
