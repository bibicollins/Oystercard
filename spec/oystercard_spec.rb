require 'oystercard'


describe Oystercard do
  subject(:oystercard) { described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

  describe 'defaults' do
    it 'has an empty list of journeys' do
      expect(oystercard.journeys).to be_empty
    end

    it 'has a balance of zero' do
      expect(oystercard.balance).to eq(0)
    end
  end

  context 'it has low balance' do
    describe '#touch_in' do
      it 'will not touch in if below minimum balance' do
        expect { oystercard.touch_in(entry_station) }.to raise_error "Insufficient balance to touch in"
      end
    end

    describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'can top up balance' do
        expect { oystercard.top_up(1) }.to change{ oystercard.balance }.by 1
      end
    end
  end

  context 'with full balance' do
    let(:journey) { double(:journey) }
    let(:station) { double(:station) }

    before do
      oystercard.instance_variable_set(:@balance, Oystercard::MAXIMUM_BALANCE)
    end

    # it { is_expected.to respond_to(:deduct).with(1).argument }
    describe '#touch_in' do
      it 'can touch in' do
        allow(Journey).to receive(:new) { journey }
        oystercard.touch_in(entry_station)
        expect(oystercard.current_journey).to eq journey
      end
    end

    describe '#top_up' do
      it 'raises error if the maximum amount is exceeded' do
        expect { oystercard.top_up(1) }.to raise_error "Maximum balance of #{Oystercard::MAXIMUM_BALANCE} exceeded"
      end
    end

    describe '#deduct' do
      Oystercard.send(:public, :deduct)
      it 'can deduct an amount from the balance' do
        expect { oystercard.deduct(5) }.to change { oystercard.balance }.by(-5)
      end
    end

    describe '#touch_out' do
      it 'can touch out' do
        oystercard.instance_variable_set(:@current_journey, journey)
        allow(journey).to receive(:calculate_fare) { 0 }
        allow(journey).to receive(:complete)
        oystercard.touch_out(exit_station)
        expect(oystercard.current_journey).to eq nil
      end

      it 'stores journey information' do
        expect(oystercard).to receive(:store_journey)
        oystercard.touch_out(station)
      end

      it 'deduct the minimum charge when touch out' do
        oystercard.instance_variable_set(:@current_journey, journey)
        allow(journey).to receive(:calculate_fare) { 0 }
        allow(journey).to receive(:complete)
        expect(oystercard).to receive(:deduct)
        oystercard.touch_out(station)
      end
    end
  end
end
