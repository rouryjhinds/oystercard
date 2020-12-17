require 'oystercard'
# rspec ./spec/oystercard_spec.rb

describe Oystercard do
  let(:station){ double :station }

  it 'balance defaults to zero' do
    expect(subject.balance).to eq(0)
  end

  describe 'journey status' do
    it 'default state is not in a journey' do
      expect(subject.in_journey?).to eq false
    end

    describe '#touch_in' do
      it 'can touch in' do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject.in_journey?).to eq true
      end
      it 'raise error if below minimum balance' do
        expect { subject.touch_in(station) }.to raise_error "insufficient funds"
      end
      it 'remembers entry station' do
        subject.top_up(5)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end
    end

    describe '#touch_out' do
      it 'can touch out' do
        subject.top_up(5)
        subject.touch_in(station)
        subject.touch_out
        expect(subject.in_journey?).to eq false
      end
      it 'pay for the journey on touch out' do
        subject.top_up(5)
        subject.touch_in(station)
        expect { subject.touch_out }.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
      end
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

 
end