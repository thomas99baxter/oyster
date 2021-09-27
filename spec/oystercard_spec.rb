require 'oystercard'
describe Oystercard do
  it "should initialize the class" do
    expect(subject.class).to eq(Oystercard)
  end

  it "should initialize the class" do
    expect(subject.balance).to eq(0)
  end
end