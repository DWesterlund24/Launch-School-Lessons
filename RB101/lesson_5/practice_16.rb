# Solution 1
def uuid
  hexa_digits = %w[0 1 2 3 4 5 6 7 8 9 a b c d e f]
  new_uuid = ''

  32.times { new_uuid << hexa_digits.sample }
  count = 8
  4.times do
    new_uuid.insert(count, '-')
    count += 5
  end
  new_uuid
end

p uuid

# Solution 2
def uuid_v2
  hexa_digits = %w[0 1 2 3 4 5 6 7 8 9 a b c d e f]
  new_uuid = ''

  count = 0
  32.times do
    new_uuid << '-' if count == 8 || count == 12 || count == 16 || count == 20
    new_uuid << hexa_digits.sample
    count += 1
  end
  new_uuid
end

p uuid_v2

# Solution 3
def uuid_v3
  hexa_digits = %w[0 1 2 3 4 5 6 7 8 9 a b c d e f]
  template = "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

  new_uuid = template.chars.map do |char|
    char == '-' ? '-' : hexa_digits.sample
  end

  new_uuid.join
end

p uuid_v3

# LS School
def generate_UUID
  characters = []
  (0..9).each { |digit| characters << digit.to_s }
  ('a'..'f').each { |digit| characters << digit }

  uuid = ''
  sections = [8, 4, 4, 4, 12]
  sections.each_with_index do |section, index|
    section.times { uuid += characters.sample }
    uuid += '-' unless index >= sections.size - 1
  end

  uuid
end

p generate_UUID

# LS Inspired Solution
def uuid_v4
  hexa_digits = %w[0 1 2 3 4 5 6 7 8 9 a b c d e f]
  new_uuid = ''

  sections = [8, 4, 4, 4, 12]
  sections.each do |section|
    section.times { new_uuid << hexa_digits.sample }
    new_uuid << '-' unless section == sections.last
  end
  new_uuid
end

p uuid_v4
