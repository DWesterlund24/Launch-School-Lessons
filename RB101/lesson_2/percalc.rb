# Calculator before walkthrough
def calculator(num1, num2, op)
  case op
  when 'addition' then num1 + num2
  when 'subtraction' then num1 - num2
  when 'multiplication' then num1 * num2
  when 'division' then num1 / num2
  end
end

num1 = nil
num2 = nil
operation = nil

loop do
  puts ">> Please type a number"
  num1 = gets.chomp.to_i
  break if num1
  puts ">> Invalid input"
end

loop do
  puts ">> Please type another number"
  num2 = gets.chomp.to_i
  break if num2
  puts ">> Invalid input"
end

loop do
  puts ">> Please type your operation (addition, subtraction, multiplication, or division)"
  operation = gets.chomp
  case operation
  when 'addition', 'subtraction', 'multiplication', 'division' then break  
  end
  puts ">> Invalid input"
end

puts calculator(num1, num2, operation)