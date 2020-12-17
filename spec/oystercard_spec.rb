require 'oystercard'
# rspec ./spec/oystercard_spec.rb

describe Oystercard do
  let(:station){ double :station }
  let(:exit_station){ double :exit_station }
  let(:oystercard_in_journey) { subject.touch_in(station) }
  let(:topped_up_card) { subject.top_up(Oystercard::MINIMUM_FARE) }


  it 'balance defaults to zero' do
    expect(subject.balance).to eq(0)
  end

  describe 'journey status' do
    it 'default state is not in a journey' do
      expect(subject.in_journey?).to eq false
    end

    describe '#touch_in' do
      it 'can touch in' do
        topped_up_card
        oystercard_in_journey
        expect(subject.in_journey?).to eq true
      end
      it 'raise error if below minimum balance' do
        expect { subject.touch_in(station) }.to raise_error "insufficient funds"
      end
      it 'remembers entry station' do
        topped_up_card
        oystercard_in_journey
        expect(subject.entry_station).to eq station
      end
    end

    describe '#touch_out' do
      it 'can touch out' do
        topped_up_card
        oystercard_in_journey
        subject.touch_out(station)
        expect(subject.in_journey?).to eq false
      end
      it 'pay for the journey on touch out' do
        topped_up_card
        oystercard_in_journey
        expect { subject.touch_out(station) }.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
      end
      it 'remembers exit station' do
        topped_up_card
        oystercard_in_journey
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq exit_station
      end
    end
    describe 'storing journeys' do
      let(:journey){ {entry_station: station, exit_station: exit_station} }

      it 'by default there is no journey list' do
        expect(subject.journeys).to be_empty
      end
      it 'stores a complete journey' do
        topped_up_card
        subject.touch_in(station)
        subject.touch_out(exit_station)
        expect(subject.journeys).to include journey
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
      topped_up_card
      expect { subject.top_up(balance_limit) }.to raise_error "top up balance of #{balance_limit} exceeded"
    end
  end

end