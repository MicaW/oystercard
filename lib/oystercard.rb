require_relative 'station'

class Oystercard
attr_reader :balance, :entry_station, :journeys, :current_journey

  DEFAULT_BALANCE = 0
  LIMIT = 90
  MIN_FARE = 1

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
    raise "Insufficient funds" if balance < MIN_FARE
    create_journey(entry_station)
    @entry_station = entry_station
    total_balance
  end

  def touch_out(exit_station)
    deduct
    log_journey
    @entry_station = nil
    total_balance
  end

  def total_balance
    "Your balance is £#{balance}"
  end

  # def journey_log(entry_station, exit_station)
  #   @journeys << { entry_station: entry_station, exit_station: exit_station }
  # end

  def log_journey
    @journeys << @current_journey
  end

private

  def deduct(fare=MIN_FARE)
    @balance -= fare
  end

  def create_journey(entry_station)
    @current_journey = Journey.new(entry_station)
  end
end
