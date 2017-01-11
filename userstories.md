###User Story 1###
In order to use public transport
As a customer
I want money on my card

###User Story 2###
In order to keep using public transport
As a customer
I want to add money to my card

###User Story 3###
In order to protect my money from theft or loss
As a customer
I want a maximum limit (of £90) on my card

###User Story 4###
In order to pay for my journey
As a customer
I need my fare deducted from my card

###User Story 5###
In order to get through the barriers.
As a customer
I need to touch in and out

###User Story 6###
In order to pay for my journey
As a customer
I need to have the minimum amount (£1) for a single journey.

###User Story 7###
In order to pay for my journey
As a customer
When my journey is complete, I need the correct amount deducted from my card

###User Story 8###
In order to pay for my journey
As a customer
I need to know where I've travelled from

###User Story 9###
In order to know where I have been
As a customer
I want to see to all my previous trips

###User Story 10###
In order to know how far I have travelled
As a customer
I want to know what zone a station is in


###Functional Representation###
Object | Message?
card | balance
card | top_up
card | max_limit
card | deduct
card | touch_in/out
card | in_journey?
card | min_balance
card | correct_amount_deducted
card | entry_station
card | journey_log
station | zone

###Nouns & Verbs###
noun | verb
public transport | use
customer | want
money | add, deduct
card | limit
barriers | touch_in/out
card | min balance
