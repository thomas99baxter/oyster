require 'oystercard'
require 'station'
require 'journey'

describe Journey do
  let(:station) {double :station}
  let(:exit_station) {double :station}
  describe "#initialize" do
    it "should be a journey" do
      expect(described_class.new(station).class).to eq(Journey)
    end

    it "should initialize with a full journey hash" do
      expect(described_class.new(station).full_journey.class).to eq(Hash)
    end

    it "should initialize with a full journey hash" do
      expect(described_class.new(station).full_journey).to eq({
        "entry_station" => station,
        "exit_station" => nil
      })
    end
  end

  describe "#end_journey" do
    it "should set full journey's exit station property" do
      test_journey = described_class.new(station)
      expect(test_journey.full_journey).to eq({
        "entry_station" => station,
        "exit_station" => nil
      })

      test_journey.end_journey(exit_station)
      expect(test_journey.full_journey).to eq({
        "entry_station" => station,
        "exit_station" => exit_station
      })
    end
  end
end