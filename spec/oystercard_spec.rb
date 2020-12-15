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
  end
end