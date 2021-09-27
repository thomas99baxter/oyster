require 'oystercard'
describe Oystercard do
  
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
  end

  describe "#top_up" do
    it "should top balance by specified amount" do
      subject.top_up(10)
      expect(subject.balance).to eq(10)
    end

    it "should top balance by specified amount when balance is less than full" do
      subject.top_up(80)
  
      expect{subject.top_up(20)}.to raise_error("Over £#{described_class::MAX_BALANCE} balance limit!")
    end

    it "should not top up balance if above deposit limit" do
      expect{subject.top_up(100)}.to raise_error("Over £#{described_class::MAX_BALANCE} balance limit!")
    end
  end

  describe "#deduct" do
    it "should deduct money from account" do
      subject.top_up(10)
      subject.deduct(5)
      expect(subject.balance).to eq(5)
    end

    it "should not deduct money from account if amount is more than balance" do
      expect{subject.deduct(5)}.to raise_error(described_class::INSUFFICIENT_ERROR_MSG)
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

      test_card.touch_in

      expect(test_card.in_journey?).to eq(true)
    end

    it "should raise an error if not enough in balance and not change in_journey property" do
      test_card = described_class.new

      expect{test_card.touch_in(described_class::MINIMUM_FARE)}.to raise_error(described_class::INSUFFICIENT_ERROR_MSG)

      expect(test_card.in_journey?).to eq(false)
    end
  end

  describe "#touch_out" do
    it "should change the in_journey property to false" do
      test_card = described_class.new(10)

      test_card.touch_in
      test_card.touch_out

      expect(test_card.in_journey?).to eq(false)
    end
  end
end