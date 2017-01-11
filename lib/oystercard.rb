require_relative 'station'

class Oystercard
attr_reader :balance, :entry_station, :journeys, :current_journey

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MIN_BALANCE = 1

  def initialize(balance=DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
    @current_journey = nil
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
    start_journey(entry_station)
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


private

  def deduct(fare)
    @balance -= fare
  end

  def start_journey(entry_station)
    Journey.new(entry_station)
  end
end
