# frozen_string_literal: true

require 'journey_log'

describe JourneyLog do
  let(:journey) { double :journey }
  describe '#initialize' do
    it 'should initalize a JourneyLog' do
      expect(described_class.new.class).to eq(JourneyLog)
    end

    it 'should initalize a JourneyLog with journeys' do
      expect(described_class.new.journeys).to eq([])
    end
  end

  describe '#add_journey' do
    it 'should add a journey to the journeys array' do
      test_journeys = described_class.new
      expect do
        test_journeys.add_journey(journey)
      end.to change { test_journeys.journeys }.from([]).to([journey])
    end

    it 'should add multiple journeys to the journeys array' do
      test_journeys = described_class.new
      expect do
        10.times do
          test_journeys.add_journey(journey)
        end
      end.to change { test_journeys.journeys }.from([]).to(
        [
          journey, journey, journey, journey, journey,
          journey, journey, journey, journey, journey
        ]
      )
    end
  end
end
