require "journey"
require "oystercard"

describe Journey do

  let(:entry_station) { instance_double("Station") }
  let(:exit_station) { instance_double("Station") }
  let(:oystercard) { instance_double("Oystercard") }

  subject(:journey) { described_class.new(entry_station) }

  it { is_expected.to respond_to(:entry_station) }

  it { is_expected.to respond_to(:exit_station) }

  it "remembers which station the card touched in" do
    expect(journey.entry_station).to eq entry_station
  end

end
