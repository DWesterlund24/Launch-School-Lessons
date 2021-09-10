puts "Welcome to the Rock Paper Scissors game!"
rps_number = [0, 1, 2]
rps_name = [%w'Rock', 'Paper', 'Scissors']

loop do
  player_choice = loop do
                    puts "Pick a choice: Rock, Paper, or Scissors (R, P, S)"
                    player_choice = gets.chomp
                    case player_choice.downcase
                    when 'r', 'rock' then break 0
                    when 'p', 'paper' then break 1
                    when 's', 'scissor' then break 2
                    end
                  end
  puts "You chose #{rps_name[player_choice]}"
  

  opponent_choice = rps_number.sample
  puts "Opponent chooses #{rps_name[opponent_choice]}"

  outcome = case player_choice
            when opponent_choice then 'tie'
            when opponent_choice + 1 then 'win'
            when 0 && opponent_choice == 2 then 'win'
            else 'lose'
            end

  case outcome
  when 'tie' then puts "Tie Game!"
  when 'win' then puts "You win!"
  when 'lose' then puts "Opponent wins."
  end

  puts "Would you like to play again? (y/n)"
  play_again = gets.chomp
  break if play_again.downcase == 'n' || play_again.downcase == 'no'
end