VALID_CHOICES = %w(rock paper scissors spock lizard)
VALID_ABBREVIATIONS = %w(r p sc sp l)
score = [0, 0]

options = {
  rock: ['scissors', 'lizard'],
  paper: ['rock', 'spock'],
  scissors: ['paper', 'lizard'],
  lizard: ['spock', 'paper'],
  spock: ['scissors', 'rock']
}

def win?(first, second, options)
  options[first.to_sym].include?(second)
end

def player_win?(player, computer, options)
  if win?(player, computer, options)
    true
  elsif win?(computer, player, options)
    false
  end
end

def scores(outcome, score)
  case outcome
  when true
    score[0] += 1
  when false
    score[1] += 1
  end
end

def display_result(outcome)
  case outcome
  when true
    "You won!"
  when false
    "Computer won!"
  else
    "It's a tie!"
  end
end

def prompt(message)
  puts "=> #{message}"
end

loop do
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}
          (#{VALID_ABBREVIATIONS.join(', ')})")
    choice = gets.chomp

    if VALID_CHOICES.include?(choice)
      break
    elsif VALID_ABBREVIATIONS.include?(choice)
      rps_number = VALID_ABBREVIATIONS.each_index do |index|
        break index if choice == VALID_ABBREVIATIONS[index]
      end
      choice = VALID_CHOICES[rps_number]
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  prompt "You chose #{choice}; Computer chose: #{computer_choice}"

  outcome = player_win?(choice, computer_choice, options)
  prompt display_result(outcome)
  scores(outcome, score)

  prompt <<-MSG
    Current score is:
    Player: #{score[0]}
    Computer: #{score[1]}
  MSG

  prompt("Do you want to play again?")
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Goodbye!")
