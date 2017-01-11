require 'station'

describe Station do
  let(:zone) {1}
  let(:name) {"Bank"}
  subject(:station) { described_class.new(zone, name) }
  it {is_expected.to respond_to(:zone)}
  it {is_expected.to respond_to(:name)}
end
