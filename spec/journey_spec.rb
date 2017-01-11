require "journey"

describe Journey do

  let(:entry_station) { instance_double("Station") }
  let(:exit_station) { instance_double("Station") }

  subject(:journey) { described_class.new(entry_station) }

  it { is_expected.to respond_to(:entry_station) }
end
