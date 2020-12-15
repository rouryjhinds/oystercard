require 'oystercard'
# rspec ./spec/oystercard_spec.rb

describe Oystercard do
  it 'balance defaults to zero' do
    expect(subject.balance).to eq(0)
  end

  describe 'journey status' do
    it 'default state is not in a journey' do
      expect(subject.in_journey?).to eq false
    end
    it 'can touch in' do
      subject.touch_in
      expect(subject.in_journey?).to eq true
    end
    it 'can touch out' do
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to eq false
    end
  end

  describe '#top_up' do
    it 'can increase balance' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end
    it 'throws an error if new balance will exceed limit' do
      balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(rand(1..90))
      expect { subject.top_up(balance_limit) }.to raise_error "top up balance of #{balance_limit} exceeded"
    end
  end

  describe '#deduct' do
    it 'deducts fare from oystercard' do
      subject.top_up(10)
      expect(subject.deduct(5)).to eq(5)
    end
  end
end