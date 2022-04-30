```ruby
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
```

Ben is correct that we do not need to prepend a `@` to `balance` on line 9. Ben has implemented a setter method for `@balance` using `attr_reader` so this is no longer necessary.

Ben did make an odd choice though by returning true when the balance is 0. I would not normally consider 0 to be positive.
