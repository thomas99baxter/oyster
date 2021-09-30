# frozen_string_literal: true

require 'oystercard'
require 'station'
require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1 }
  let(:exit_station) { double :station, zone: 1 }

  describe '#initialize' do
    it 'should be a journey' do
      expect(described_class.new.class).to eq(Journey)
    end

    it 'should initialize with a full journey hash' do
      expect(described_class.new.full_journey.class).to eq(Hash)
      expect(described_class.new.full_journey).to eq({
                                                       entry_station: nil,
                                                       exit_station: nil
                                                     })
    end

    it 'should initialize a fare instance variable' do
      expect(described_class.new.fare).to eq(0)
    end
  end

  describe '#start_journey' do
    it 'should set entry station' do
      test_journey = described_class.new

      expect do
        test_journey.start_journey(station)
      end.to change { test_journey.full_journey[:entry_station] }.from(nil).to(station)
    end
  end

  describe '#end_journey' do
    it "should set full journey's exit station property" do
      test_journey = described_class.new
      expect(test_journey.full_journey).to eq({
                                                entry_station: nil,
                                                exit_station: nil
                                              })

      test_journey.start_journey(station)
      test_journey.end_journey(exit_station)
      expect(test_journey.full_journey).to eq({
                                                entry_station: station,
                                                exit_station: exit_station
                                              })
    end
  end

  describe '#add_to_fare' do
    it 'should add to fare instance variable' do
      new_journey = described_class.new
      new_journey.add_to_fare(10)
      expect(new_journey.fare).to eq(10)
    end
  end

  describe '#calculate_total_fare' do
    it 'should calculate the correct difference between zones when zones are the same' do
      new_journey = described_class.new

      new_journey.start_journey(station)
      new_journey.end_journey(exit_station)

      expect(new_journey.calculate_total_fare).to eq(0)
    end

    it 'should calculate the correct difference between zones when zones are different' do
      allow(station).to receive(:zone).and_return(1)
      allow(exit_station).to receive(:zone).and_return(3)
      new_journey = described_class.new

      new_journey.start_journey(station)
      new_journey.end_journey(exit_station)

      expect(new_journey.calculate_total_fare).to eq(2)
    end

    it 'should calculate the correct difference between zones when zones are different' do
      allow(station).to receive(:zone).and_return(3)
      allow(exit_station).to receive(:zone).and_return(1)
      new_journey = described_class.new

      new_journey.start_journey(station)
      new_journey.end_journey(exit_station)

      expect(new_journey.calculate_total_fare).to eq(2)
    end
  end
end
