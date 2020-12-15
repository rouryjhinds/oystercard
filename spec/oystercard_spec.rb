require 'oystercard'
# rspec ./spec/oystercard_spec.rb

describe Oystercard do
  it 'balance defaults to zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it 'can increase balance' do
      subject.top_up(5)
      expect(subject.balance).to eq(5)
    end
    it 'throws an error if new balance will exceed limit' do
      balance_limit = Oystercard::BALANCE_LIMIT
      subject.top_up(balance_limit)
      expect { subject.top_up(1) }.to raise_error 'top up balance exceeded'
    end
  end
end