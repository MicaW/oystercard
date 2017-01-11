#Read Me#

the card will have a default value of 0, the value is its balance. To test in IRB, we would like to make an instance (os) of Oystercard, and check to see its default balance. I would then like to add money to this balance. To check in IRB: using (os) instance, with top_up to see if balance increases (default_balance + top_up(amount)).

The card has a upper limit of £90. To check in IRB we will try and top up by a value greater than £90, assuming a balance of 0, and expect an error to be raised.

Once the card has a balance, we would like to be able to deduct money from it to pay for fares. To check in IRB: using (os) instance with deduct(fare) to see if balance decreases by deducted amount (balance - deduct(fare)).

If I need to pay for a fare, the minimum balance on my card should be at least £1. To test this in IRB: use os instance and expect os.deduct(x) to raise error if balance =< £1

Once user's journey is complete, oystercard needs to be deducted by total fare. Test in IRB: os.top_up(1), os.touch_in, os.touch_out, os.deduct(fare).

The oystercard needs to remember the entry station of the current journey. Test in IRB: oystercard = Oystercard.new, oystercard.top_up, oystercard.touch_in(station), oystercard.entry_station

The user wants to see a log of previous journeys made. IRB: os.top_up(5), os.touch_in('station'), os.touch_out(2), os.journey_log

The user wants to see which zone their station in. 
