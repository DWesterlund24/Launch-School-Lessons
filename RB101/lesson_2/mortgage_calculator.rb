require 'yaml'
MESSAGES = YAML.load_file('mortgage_calculator_messages.yml')

def prompt(message)
  puts "=> " + message
end

def valid_number?(number, include_0=false)
  if (number.to_i.to_s == number || number.to_f.to_s == number) &&
     number.to_i.positive?
    return true
  end
  include_0 == true && number == 0
end

def usd(number)
  dollars = number.to_f.round(2).to_s
  dollars += '0' if dollars [-2] == '.'
  count = -3
  loop do
    count -= 4
    break if dollars[count].nil?
    dollars.insert(count, ',')
  end
  "$" + dollars
end

prompt MESSAGES['welcome']

loan_amount = nil
apr = nil
loan_duration = nil

loop do
  # Get loan amount
  loop do
    prompt MESSAGES['loan_amount']
    loan_amount = gets.chomp
    loan_amount.gsub!(/['$,']/, '')
    break if valid_number?(loan_amount)
    prompt MESSAGES['invalid_number']
  end

  # Get APR
  loop do
    prompt MESSAGES['apr']
    apr = gets.chomp
    apr.gsub!('%', '')
    break if valid_number?(apr, true)
    prompt MESSAGES['invalid_number']
  end

  # Get loan duration
  prompt MESSAGES['loan_duration']
  loop do
    years = nil
    months = nil
    loop do
      prompt MESSAGES['years']
      years = gets.chomp
      break if years == '' || valid_number?(years, true)
      prompt MESSAGES['invalid_number']
    end
    loop do
      prompt MESSAGES['months']
      months = gets.chomp
      break if months == '' || valid_number?(months, true)
      prompt MESSAGES['invalid_number']
    end
    loan_duration = (years.to_i * 12) + months.to_i
    break if loan_duration > 0
    prompt MESSAGES['invalid_duration']
  end

  # Verify information is correct
  prompt <<-MSG
  This is the information we have collected:
  The loan amount is #{usd(loan_amount)}.
  The APR is #{apr}%.
  The loan duration is #{(loan_duration)} months or #{loan_duration / 12.0} years.
  Does this look correct? (Y/N)
  MSG

  response = gets.chomp
  unless response.downcase.start_with?('y')
    prompt MESSAGES['try_again']
    next
  end

  # Calculate monthly payment
  monthly_interest_rate = (apr.to_f / 100) / 12
  monthly_payment = loan_amount.to_f * (monthly_interest_rate / \
                    (1 - (1 + monthly_interest_rate)**(-loan_duration)))
  total_payment = monthly_payment.round(2) * loan_duration
  prompt "Your monthly payment will be #{usd(monthly_payment)}"
  prompt "Your total payment over #{loan_duration}
          months will be #{usd(total_payment)}"
  prompt "Total interest payed will be #{usd(total_payment - loan_amount.to_f)}"

  # Ask user if they want to use the calculator again
  prompt MESSAGES['calculate_again']
  response = gets.chomp
  break unless response.downcase.start_with?('y')
end

# Say goodbye
prompt MESSAGES['farewell']
