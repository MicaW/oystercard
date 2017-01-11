require "./lib/oystercard.rb"

oystercard = Oystercard.new
oystercard.top_up(50)

bank = Station.new(1,"Bank")
angel = Station.new(2,"Angel")
borough = Station.new(1,"Borough")
stratford = Station.new(3,"Stratford")
arsenal = Station.new(4,"Arsenal")
greenwich = Station.new(3,"Greenwich")
