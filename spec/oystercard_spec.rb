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
      expect{subject.deduct(5)}.to raise_error("You have insufficient funds in your account!")
    end
  end
end