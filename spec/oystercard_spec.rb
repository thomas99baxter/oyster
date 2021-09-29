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

    it "should initalise with attributes balance and journeys" do
      expect(described_class.new(10)).to have_attributes(balance: 10, journeys: [])
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

  describe "#attempt_touch_in" do
    it "should change the in_journey property to true if enough money in balance" do
      test_card = described_class.new(10)
      test_card.attempt_touch_in(station)

      expect(test_card.new_journey.full_journey[:entry_station]).to eq(station)
    end

    it "should raise an error if not enough in balance and not change in_journey property" do
      test_card = described_class.new

      expect{test_card.attempt_touch_in(station)}.to raise_error(described_class::INSUFFICIENT_ERROR_MSG)

    end
  end

  describe "#attempt_touch_out" do
    it "should change the in_journey property to false" do
      test_card = described_class.new(10)

      test_card.attempt_touch_in(station)
      test_card.attempt_touch_out(exit_station)
    end
    
    it "should deduct minimum fare from balance" do
      test_card = described_class.new(10)
  
      test_card.attempt_touch_in(station)
      expect{ test_card.attempt_touch_out( exit_station) }.to change{ test_card.new_journey.fare }.by(described_class::MINIMUM_FARE)
    end

    it "should fail when the journey hasnt been initiated (touched in)" do
      test_card = described_class.new(10)
  
      expect{ test_card.attempt_touch_out( exit_station) }.to change{ test_card.new_journey.fare }.by(described_class::PENALTY_FARE)
    end
  end

  describe "journey" do
    it "should have one journey after touching in and out once" do
      test_card = described_class.new(10)
  
      test_card.attempt_touch_in(station)
      test_card.attempt_touch_out(exit_station)
  
      expect(test_card.journeys.length).to eq(1)
    end
    
    it "should have 10 journeys after touching in and out 10x" do
      test_card = described_class.new(11)
      
      10.times do
        test_card.attempt_touch_in(station)
        test_card.attempt_touch_out(exit_station)
      end
  
      expect(test_card.journeys.length).to eq(10)
    end
  end

end