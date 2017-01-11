class Oystercard
attr_reader :balance, :entry_station, :journeys

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MIN_BALANCE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    raise "£#{LIMIT} limit reached" if balance + amount >= LIMIT
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    raise "Insufficient funds" if balance < MIN_BALANCE
    @entry_station = entry_station
    total_balance
  end

  def touch_out(fare, exit_station)
    deduct(fare)
    journey_log(@entry_station, exit_station)
    @entry_station = nil
    total_balance
  end

  def total_balance
    "Your balance is £#{balance}"
  end

  def journey_log(entry_station, exit_station)
    journey = {
      entry_station: entry_station,
      exit_station: exit_station
    }
    @journeys << journey
  end

  def number
    i = @journeys.count + 1
    journey + i
  end

private

  def deduct(fare)
    @balance -= fare
  end
end
