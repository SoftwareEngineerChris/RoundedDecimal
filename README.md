# RoundedDecimal
[![Build Status](https://app.bitrise.io/app/57e424b934229804/status.svg?token=zDHT8jgVf-wPoK5oVp7LcA&branch=master)](https://app.bitrise.io/app/57e424b934229804)

Swift decimals where the number of decimal places is explicitly part of the type

## Why

**_TL/DR: We would like to guarantee a level of precision, or be explicit when changing the level of precision, of decimals moving through our system._**

When dealing with decimals we often want to know; deal with; or maintain a number of decimal places in the number we're representing. 

For example when dealing with money 💵 in the simple world, for example in a shopping application, we often want to deal with numbers that have **2 decimal places**. Especially when dealing with lots of these numbers.

If we have a product that costs **$2.50** to sell in the United States 🇺🇸, and we wanted to sell it in the United Kingdom 🇬🇧, we may want to use an exchange rate to calculate the local price. If the rate provided by our API is **0.81245 USD per GBP** (or **1.23084 GBP per USD**), using a simple multiplication, we may calculate the price for the item to be **£3.0771**.

We probably don't want to present **£3.0771** to our user as they don't normally deal in fractions of pennies. In our presentation layer we may format the value in the receipt as **£3.08**. The user has decided to order **300** of these items. The calculation part of our application doesn't necessarily know how the data is being presented, so deals with the item price of **£3.0771**. Therefore, **£3.0771** multiplied by **300** is **£923.13**.

In this case we may present a receipt 🧾 to the user which looks like: `Special Product @ £3.08 x 300 = £923.13`

Except **300** multiplied by **£3.08** _isn't_ **£923.13**. It's **£924.00**. Our user is confused about the total we're presenting to them, not realising that our calculation used a price of £3.0771 per item rather than the £3.08 presented to them. Not only that, but we're sending the presented item price to our analytics system - and its not aligning with the totals in our sales system. What a nightmare 🤯.

What they should have seen on their receipt is either:
`Special Product @ £3.08 x 300 = £924.00` or  `Special Product @ £3.0771 x 300 = £923.13`

Of course, how this is handled should be a business decision 📈, but we should be able to guarantee the decision in our code. If we can leverage the type system to help us out, we can make this a compile-time requirement. `RoundedDecimal` can help us with that.
