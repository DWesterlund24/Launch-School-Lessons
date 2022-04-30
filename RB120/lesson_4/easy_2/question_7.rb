class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

cat1 = Cat.new('Tabby')
cat2 = Cat.new('Siamese')
cat3 = cat1

# cat3 points to the same object as cat1, therefore there are still only two Cat objects.

cat4 = cat2.dup

# cat4 is a new cat object because we have use the #dup method.
# There are now 3 unique cat objects but @@cats_count only returns 2.
# We have bypassed the constructor by using #dup

puts [cat1, cat2, cat3, cat4].uniq.size == Cat.cats_count # => false
