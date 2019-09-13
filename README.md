# RoundedDecimal
[![Build Status](https://app.bitrise.io/app/57e424b934229804/status.svg?token=zDHT8jgVf-wPoK5oVp7LcA&branch=master)](https://app.bitrise.io/app/57e424b934229804) 
[![Cocoapods](https://img.shields.io/cocoapods/v/RoundedDecimal)](https://cocoapods.org/pods/RoundedDecimal)
[![SPM](https://img.shields.io/badge/SPM-Supported-informational)](#)

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

## Example usage

The way that `RoundedDecimal` works is that it forces you to think about how you would like to deal with handling numbers of varying decimal places. For example, dealing with an item price that has 2 decimal places, and an exchange rate that has 5 decimal places. Using a regular decimal you can simply do: `let localPrice: Decimal = itemPrice * exchangeRate` which may look like `2.59 * 1.12345` resulting in the value `2.9097355`. This number may go off to other parts of the system as described in the `Why` section above.

Using `RoundedDecimal`, the code has to be more explicit. For example, this code would **fail** to compile as we're trying to multiply two numbers of different precision:

```swift
let listedUSDPrice: RoundedDecimal<Places.two> = "2.59"
let exchangeRate: RoundedDecimal<Places.five> = "1.12345"
        
let localPrice = listedUSDPrice * exchangeRate
```

The compilation failure look like:

```bash
binary operator '*' cannot be applied to operands of type 'RoundedDecimal<Places.two>' and 'RoundedDecimal<Places.five>'
        let localPrice = listedUSDPrice * exchangeRate
                         ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~    
```

Instead, a decision would need to be made. Either we reduce the precision of the exchange rate to two decimal places to match that of the listed price:

```swift
let listedUSDPrice: RoundedDecimal<Places.two> = "2.59"
let exchangeRate: RoundedDecimal<Places.five> = "1.12345"

let shortExchangeRate: RoundedDecimal<Places.two> = exchangeRate.withInferredPrecision()
let localPrice = listedUSDPrice * shortExchangeRate // localPrice would result in 2.90

```

Or, we increase the precision of the listed price to five decimal places so that we can keep the precision of the exchange rate in our calculation:

```swift

let listedUSDPrice: RoundedDecimal<Places.two> = "2.59"
let exchangeRate: RoundedDecimal<Places.five> = "1.12345"

let longListedUSDPrice: RoundedDecimal<Places.five> = listedUSDPrice.withInferredPrecision()
let localPrice = longListedUSDPrice * exchangeRate // localPrice would result in 2.90974
```

Notice that each approach is explicit and results in different values. Its also worth noting that increasing the precision of the listed price doesn't actually change its value, it'll still be 2.59 but it allows it to be treated as a number with five decimal places, making it explicitly 2.59000.

### Converting precisions

As with the example shown above, when dealing with numbers of different precisions in an operation, we need to be explicit. To do this we use the Swift type system, generics and inference.

To explicitly change the precision of a number we must use `withInferredPrecision()` where the expression result is explicitly typed.

For example to convert a number with five decimal places to one which has two decimal places:

```swift
let exchangeRate: RoundedDecimal<Places.five> = "1.12345"
let shortExchangeRate: RoundedDecimal<Places.two> = exchangeRate.withInferredPrecision() // shortExchangeRate would result in 1.12
```
