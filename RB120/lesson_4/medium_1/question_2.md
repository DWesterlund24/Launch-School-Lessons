```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
```

In this example, it looks like Alan was intending to be able to update the `@quantity` instance variable by using the `update_quantity` method. The problem here is in the body of this method, he is initializing a new local variable named `quantity` instead of updating the existing instance variable. This can be fixed in two ways. We can either

Prepend `@` to `quantity` so the method body reads:

```ruby
@quantity = updated_count if updated_count >= 0
```

or create a setter method, preferably by using `attr_accessor`, and prepending `self.` to `quantity` on line 11. This solution is preffered.

```ruby
class InvoiceEntry
  attr_accessor :quantity
  attr_reader :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
end
```
