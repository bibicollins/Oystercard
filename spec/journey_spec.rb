require 'journey'
describe Journey do
  subject(:journey) { described_class.new }

  it 'is initially not in journey' do
    expect(subject).not_to be_in_journey
  end


end









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
