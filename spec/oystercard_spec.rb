require 'oystercard'
require 'station'
require 'journey'

describe Oystercard do

  let(:station) {double :station}
  let(:exit_station) {double :station}
  
  describe "#initialize" do
    it "should initialize the class" do
      expect(subject.class).to eq(Oystercard)
    end

    it "should initialize the balance to 0 if not passed" do
      expect(subject.balance).to eq(0)
    end

    it "should initialize the balance to parameter if passed" do
      expect(described_class.new(10).balance).to eq(10)
    end

    it "should initialise with an in_journey variable" do
      expect(described_class.new(10).in_journey?).to eq(false)
    end

    it "should initalise with a journeys" do
      expect(described_class.new(10).journeys).to eq([])
    end
  end

  describe "#top_up" do
    it "should top balance by specified amount when balance is less than full" do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it "should not top up balance when balance (+ top-up amount) is over or equal to maximum balance" do
      subject.top_up(80)
  
      expect{subject.top_up(20)}.to raise_error("Over £#{described_class::MAX_BALANCE} balance limit!")
    end

    it "should not top up balance if above balance limit" do
      expect{subject.top_up(100)}.to raise_error("Over £#{described_class::MAX_BALANCE} balance limit!")
    end
  end


  describe "#in_journey?" do
    it "should return a boolean" do
      expect([TrueClass, FalseClass].include?(subject.in_journey?.class)).to eq(true)
    end
  end

  describe "#touch_in" do
    it "should change the in_journey property to true if enough money in balance" do
      test_card = described_class.new(10)
      test_card.touch_in(station)

      expect(test_card.in_journey?).to eq(true)
      expect(test_card.new_journey.full_journey[:entry_station]).to eq(station)
    end

    it "should raise an error if not enough in balance and not change in_journey property" do
      test_card = described_class.new

      expect{test_card.touch_in(station)}.to raise_error(described_class::INSUFFICIENT_ERROR_MSG)

      expect(test_card.in_journey?).to eq(false)
    end
  end

  describe "#touch_out" do
    it "should change the in_journey property to false" do
      test_card = described_class.new(10)

      test_card.touch_in(station)
      test_card.touch_out(exit_station)

      expect(test_card.in_journey?).to eq(false)
    end
    
    it "should deduct minimum fare from balance" do
      test_card = described_class.new(10)
  
      test_card.touch_in(station)
  
      expect{ test_card.touch_out( exit_station) }.to change{ test_card.balance }.by(-described_class::MINIMUM_FARE)
    end
  end

end