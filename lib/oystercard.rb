require_relative 'station'
require_relative 'journey'

class Oystercard
attr_reader :balance, :entry_station, :journeys, :current_journey

  DEFAULT_BALANCE = 0
  LIMIT = 90

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
    !@current_journey.nil?
  end

  def touch_in(entry_station)
    charge_penalty if in_journey?
    raise "Insufficient funds" if balance < Journey::MIN_FARE
    create_journey(entry_station)
    total_balance
  end

  def touch_out(exit_station)
    @current_journey.finish_journey(exit_station)
    deduct
    log_journey
    total_balance
    @current_journey = nil
  end

  def total_balance
    "Your balance is £#{balance}"
  end

  def charge_penalty
    @current_journey.finish_journey(exit_station)
    deduct(true)
  end

  # def journey_log(entry_station, exit_station)
  #   @journeys << { entry_station: entry_station, exit_station: exit_station }
  # end

  def log_journey
    @journeys << @current_journey
  end

private

  def deduct(penalty = false)
    @balance -= @current_journey.fare(penalty)
  end

  def create_journey(entry_station)
    @current_journey = Journey.new(entry_station)
  end

end
