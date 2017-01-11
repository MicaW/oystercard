require 'oystercard'



describe Oystercard do

  subject(:oystercard) { described_class.new }
  minb = Oystercard::MIN_BALANCE
  amount = 10
  fare = 5

  let(:entry_station) {double :victoria}
  let(:exit_station) {double :euston}

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
  end

  describe "#top_up" do
    it { should respond_to(:top_up).with(1).argument }
    it "adds money to the card's balance" do
      expect{ oystercard.top_up(amount) }.to change{ oystercard.balance }.by amount
    end
  end

  describe "#in_journey?" do
    before(:each) do
      oystercard.top_up(minb)
      oystercard.touch_in(entry_station)
    end
    it "changes to true when touched in" do
      expect(oystercard).to be_in_journey
    end
    it "changes to false when touched out" do
      oystercard.touch_out(fare, exit_station)
      expect(oystercard).not_to be_in_journey
    end
  end

  describe "#touch_in" do
    it { should respond_to(:touch_in).with(1).argument }
    it "raises error if insufficient balance" do
      error = "Insufficient funds"
      expect{ oystercard.touch_in(entry_station) }.to raise_error(error)
    end
    it "remembers which station the card touched in" do
    oystercard.top_up(amount)
    oystercard.touch_in(entry_station)
    expect(oystercard.entry_station).to eq entry_station
  end
  end

  describe "#touch_out" do
    before(:each) do
      oystercard.top_up(minb)
      oystercard.touch_in(entry_station)
    end
    it { should respond_to(:touch_out).with(2).argument }
    it "deducts the correct fare after the journey" do
      expect{oystercard.touch_out(fare, exit_station)}.to change{oystercard.balance}.by -fare
    end
    it "forgets the entry station" do
      oystercard.touch_out(fare, exit_station)
      expect(oystercard.entry_station).to be_nil
    end
  end

  describe "#journey_log" do
      before(:each) do
        oystercard.top_up(minb)
        oystercard.touch_in(entry_station)
        oystercard.touch_out(2, exit_station)
      end
      it "has the entry station" do
        expect(oystercard.journeys[0][:entry_station]).to eq(entry_station)
      end
      it "has the exit station" do
        expect(oystercard.journeys[0][:exit_station]).to eq(exit_station)
      end
      it "stores entry & exit stations as one journey" do
        expect(oystercard.journeys[0]).to include(:entry_station, :exit_station)
      end
  end
end
