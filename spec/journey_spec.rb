require 'journey'
describe Journey do
  subject(:journey) { described_class.new }
  let(:station) { double :station }

  describe '#initialize' do
    it 'sets an exit_station if given an argument' do
      expect(Journey.new(station).entry_station).to eq station
    end
    it 'sets a default value if not given and argument' do
      expect(subject.entry_station).to eq nil
    end
  end

  describe '#complete(station)' do
    it 'completes a journey when given an exit_station' do
      subject.complete(station)
      expect(subject).not_to be_in_journey
    end

    it 'sets the exit_station' do
      subject.complete(station)
      expect(subject.exit_station).to eq station
    end
  end

  describe '#calculate_fare' do
    it 'returns the minimum fare for a complete journey' do
      subject.instance_variable_set(:@exit_station, station)
      subject.instance_variable_set(:@entry_station, station)
      expect(subject.calculate_fare).to eq Journey::MINIMUM_FARE
    end
    it 'returns the penalty fare amount for an incomplete journey' do
      expect(subject.calculate_fare).to eq Journey::PENALTY_FARE
    end
  end
end






  # it 'stores journey information' do
  #   oystercard.touch_in(entry_station)
  #   oystercard.touch_out(exit_station)
  #   expect(oystercard.journeys).to include journey
  # end










# let(:journey) {Journey.new(entry_station)}
# let(:entry_station) { double :station, zone: 1 }
# let(:exit_station) { double :station, zone: 2 }
#
#
#
#
#
#
# it 'accepts the entry station when touch in' do
#   expect(journey.entry_station).to eq entry_station
#   end
#
#   it 'accepts a exit_station when we touch out' do
#     expect(journey.complete_journey(exit_station)).to eq exit_station
#   end
#
# end
