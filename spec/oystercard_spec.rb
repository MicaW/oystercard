require 'oystercard'
require 'journey'


describe Oystercard do

  subject(:oystercard) { described_class.new }
  fare = Journey::MIN_FARE
  amount = fare + 10

  let(:entry_station) {double :victoria}
  let(:exit_station) {double :euston}
  let(:journey) { instance_double("Journey") }

  db = Oystercard::DEFAULT_BALANCE
  limit = Oystercard::LIMIT

  describe "balance" do
    it "balance will not exceed £#{limit}" do
      error = "£#{limit} limit reached"
      expect {oystercard.top_up(limit) }.to raise_error(error)
    end
  end

  context "On initialization" do
    it "has default balance of £#{db}" do
      expect( oystercard.balance ).to eq db
    end
    it "is initially not in a journey" do
      expect(oystercard).not_to be_in_journey
    end
    it "has no journeys by default" do
      expect(oystercard.journeys).to be_empty
    end
    it "has no current journey" do
      expect(oystercard.current_journey).to be_nil
    end
  end

  describe "#top_up" do
    it { should respond_to(:top_up).with(1).argument }
    it "adds money to the card's balance" do
      expect{ oystercard.top_up(amount) }.to change{ oystercard.balance }.by amount
    end
  end

  describe "#in_journey?" do
    before(:each) do
      oystercard.top_up(amount)
      oystercard.touch_in(entry_station)
    end
    it "changes to true when touched in" do
      expect(oystercard).to be_in_journey
    end
    it "changes to false when touched out" do
      oystercard.touch_out(exit_station)
      expect(oystercard).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it { should respond_to(:touch_in).with(1).argument }
    it "raises error if insufficient balance" do
      error = "Insufficient funds"
      expect{ oystercard.touch_in(entry_station) }.to raise_error(error)
    end
    it 'creates a journey upon touch-in' do
      oystercard.top_up(amount)
      oystercard.touch_in(entry_station)
      expect(oystercard.current_journey).to be_a Journey
    end
  end

  describe "#touch_out" do
    before(:each) do
      oystercard.top_up(amount)
      oystercard.touch_in(entry_station)
    end
    it "deducts the correct fare after the journey" do
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by -fare
    end
    it "finishes the current journey when touching out" do
      oystercard.touch_out(exit_station)
      expect(oystercard.current_journey).to be_nil
    end
  end

  describe "#log_journey" do
      before(:each) do
        oystercard.top_up(amount)
        oystercard.touch_in(entry_station)
      end
      it 'logs finished journey' do
        expect{oystercard.touch_out(exit_station)}.to change{oystercard.journeys.count}.by 1
        expect(oystercard.journeys[-1]).to be_a Journey
      end
  end

end
