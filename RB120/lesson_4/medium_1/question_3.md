```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end
```

The only problem I foresee with introducing `attr_accessor :quantity`, is a problem of encapsulation. If we're trying to prohibit the user from changing `@quantity` to a negative value(as it would seem is Alan's intention), then we should not have the public access to the `@quantity` setter method. We should write a private setter method instead, preferrably using `attr_writer`.

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end

  private

  attr_writer :quantity
end
```
