CARDS_IN_SUIT = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                  '8' => 8, '9' => 9, '10' => 10, 'Jack' => 10, 'Queen' => 10,
                  'King' => 10, 'Ace' => 11 }.freeze
SUIT_NAMES = ['Clubs', 'Diamonds', 'Hearts', 'Spades'].freeze
TARGET_NUMBER = 21

DISPLAY_SPACE = 19

def prompt(string)
  puts('=> ' + string)
end

def wait_for_user
  puts ''
  prompt 'Press enter to conitinue'
  gets
end

def clear_terminal
  system 'clear'
end

def create_deck(array_of_suit_names)
  array_of_suit_names.each_with_object({}) do |suit_name, deck|
    suit = CARDS_IN_SUIT.map do |rank, value|
      [{ suit: suit_name, rank: rank }, value]
    end.to_h

    deck.merge!(suit)
  end
end

def deal_card!(deck, hand, discards)
  if deck.empty?
    (deck << discards).flatten!(2)
    discards.clear
  end

  random_card = deck.sample
  hand << random_card
  deck.delete(random_card)
end

def deal_starting_cards!(deck, participants, discard_pile)
  2.times do
    participants.each do |_, attributes|
      deal_card!(deck, attributes[:hand], discard_pile)
      update_score!(attributes)
      convert_ace_if_needed!(attributes)
    end
  end
end

def get_card_name(card)
  return '' if card.nil?
  return card if card == 'Unknown Card'
  "#{card[:rank]} of #{card[:suit]}"
end

def get_largest_hand_size(participants)
  participants.map do |_, attributes|
    attributes[:hand].size
  end.max
end

def display_games_won(games_won)
  clear_terminal
  puts ' Games Won '.center(BORDER_SIZE, '=')
  games_won.each_key do |name|
    print "#{name.capitalize}: #{games_won[name]}".center(DISPLAY_SPACE + 2)
  end
  puts ''
  puts '=' * BORDER_SIZE
  puts ''
end

def center_with_border(string)
  '|' + string.center(DISPLAY_SPACE) + '|'
end

def hands_border_line(char)
  center_with_border(char * DISPLAY_SPACE) * PLAYERS
end

def grand_result_border_top(string)
  string.center(BORDER_SIZE, '*')
end

def grand_result_border_mid(string)
  '*' + string.center(BORDER_SIZE - 2) + '*'
end

def names_in_border(participants)
  string = ''

  participants.each_key do |name|
    string += center_with_border("#{name.capitalize}'s Hand")
  end
  string
end

def extract_hands(participants, show_all)
  participants.map do |_, attributes|
    attributes[:hand].map.with_index do |card, index|
      if !attributes[:user_controlled] && !show_all
        index.zero? ? card : 'Unknown Card'
      else
        card
      end
    end
  end
end

def print_hands_in_border(participants, show_all)
  largest_hand_size = get_largest_hand_size(participants)

  largest_hand_size.times do |index|
    extract_hands(participants, show_all).each do |hand|
      print center_with_border(get_card_name(hand[index]))
    end
    puts ''
  end
end

def total_in_border(participants, show_all)
  participants.each_with_object('') do |(_, attributes), string|
    score = if !attributes[:user_controlled] && !show_all
              '?'
            else
              attributes[:score].to_s
            end

    score += ' Bust!' if attributes[:bust]

    string << center_with_border("Total: #{score}")
  end
end

def display_hands(participants, show_all = false)
  puts hands_border_line('=')
  puts names_in_border(participants)
  puts hands_border_line('-')
  print_hands_in_border(participants, show_all)
  puts hands_border_line('-')
  puts total_in_border(participants, show_all)
  puts hands_border_line("=")
end

def show_grand_winner(games_won)
  clear_terminal
  winner = get_grand_winner(games_won)
  puts grand_result_border_top(' Grand Result ')
  puts grand_result_border_mid('')
  puts grand_result_border_mid("#{winner} wins!")
  puts grand_result_border_mid('')
  puts grand_result_border_top('')
end

def hit?(attributes)
  unless attributes[:stayed]
    if attributes[:user_controlled]
      user_hit?
    else
      computer_hit?(attributes)
    end
  end
end

def user_hit?
  loop do
    puts ''
    prompt 'Do you want to hit or stay? (h or s)'
    answer = gets.chomp.downcase
    return true if answer == 'h' || answer == 'hit'
    return false if answer == 's' || answer == 'stay'

    prompt 'Invalid input.'
  end
end

def computer_hit?(attributes)
  attributes[:score] < (TARGET_NUMBER - 4)
end

def deal_or_set_stayed!(deck, attributes, discard_pile)
  if hit?(attributes)
    deal_card!(deck, attributes[:hand], discard_pile)
    update_score!(attributes)
  else
    attributes[:stayed] = true
  end
end

def bust?(attributes)
  attributes[:score] > TARGET_NUMBER
end

def participants_turns!(deck, participants, discard_pile)
  participants.each do |_, attributes|
    deal_or_set_stayed!(deck, attributes, discard_pile)
    convert_ace_if_needed!(attributes)

    if bust?(attributes)
      attributes[:bust] = true
      break
    end
  end
end

def end_round?(participants)
  participants.all? { |_, attributes| attributes[:stayed] } ||
    participants.any? { |_, attributes| attributes[:bust] }
end

def update_score!(participant)
  last_card_value = ALL_CARDS[participant[:hand][-1]]

  participant[:score] += last_card_value
  participant[:ace_count] += 1 if last_card_value == 11
end

def convert_ace_if_needed!(participant)
  loop do
    if participant[:score] > TARGET_NUMBER && participant[:ace_count].positive?
      participant[:score] -= 10
      participant[:ace_count] -= 1
    else
      break
    end
  end
end

def get_result(participants)
  contenders = participants.reject { |_, attributes| attributes[:bust] }
  winner = contenders.max_by { |_, attributes| attributes[:score] }

  return winner[0] if contenders.one? do |_, attributes|
    attributes[:score] == winner[1][:score]
  end

  :tie
end

def display_winning_message(winner)
  winning_message = if winner == :tie
                      'Tie!'
                    else
                      "#{winner.capitalize} wins!"
                    end

  puts ''
  puts winning_message.center((DISPLAY_SPACE + 2) * PLAYERS)
  puts ''
end

def update_games_won!(winner, games_won)
  games_won[winner] += 1 if games_won.key?(winner)
end

def get_grand_winner(games_won)
  games_won.each_with_object('') do |(participant, won), winner|
    winner << participant.capitalize.to_s if won == 5
  end
end

def grand_winner?(games_won)
  games_won.any? { |_, won| won == 5 }
end

def continue_playing?
  loop do
    puts ''
    prompt 'Would you like to continue playing? (y or n)'
    answer = gets.chomp.downcase
    return true if answer == 'y' || answer == 'yes'
    return false if answer == 'n' || answer == 'no'

    prompt 'Invalid input'
  end
end

clear_terminal
prompt "Welcome to Twenty-one! The player with the most points without going "\
       "over the target number wins!"
prompt "The target number for this game is #{TARGET_NUMBER}. "\
       "If you go over #{TARGET_NUMBER}, you lose."
wait_for_user

PLAYERS = 2

ALL_CARDS = create_deck(SUIT_NAMES).freeze
BORDER_SIZE = 21 * PLAYERS

deck = ALL_CARDS.keys
discard_pile = []

loop do
  games_won = { player: 0, dealer: 0 }

  loop do
    participants = {
      player: { hand: [], ace_count: 0, score: 0, stayed: false,
                bust: false, user_controlled: true },
      dealer: { hand: [], ace_count: 0, score: 0, stayed: false,
                bust: false, user_controlled: false }
    }

    deal_starting_cards!(deck, participants, discard_pile)

    # Begin play
    loop do
      display_games_won(games_won)
      display_hands(participants)

      participants_turns!(deck, participants, discard_pile)

      break if end_round?(participants)
    end

    # Display Winner

    winner = get_result(participants)
    update_games_won!(winner, games_won)

    display_games_won(games_won)
    display_hands(participants, true)
    display_winning_message(winner)

    wait_for_user

    participants.each { |_, attributes| discard_pile << attributes[:hand] }

    break if grand_winner?(games_won)
  end

  show_grand_winner(games_won)

  break unless continue_playing?
end

prompt 'Thank you for playing! Goodbye!'
