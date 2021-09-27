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
  end
end