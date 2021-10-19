CARDS_IN_SUIT = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                  '8' => 8, '9' => 9, '10' => 10, 'jack' => 10, 'queen' => 10,
                  'king' => 10, 'ace' => 11 }.freeze
SUIT_NAMES = ['clubs', 'diamonds', 'hearts', 'spades'].freeze
TARGET_NUMBER = 21

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
  array_of_suit_names.each_with_object({}) do |suit_name, object|
    suit = CARDS_IN_SUIT.map do |rank, value|
      [[suit_name, rank], value]
    end.to_h

    object.merge!(suit)
  end
end

def deal_card!(deck, hand, discards)
  # Insert discards into deck when deck empty
  if deck.empty?
    (deck << discards).flatten!(2)
    discards.clear
  end

  random_card = deck.sample
  hand << random_card
  deck.delete(random_card)
end

# Return list of card names without suit
def list_cards(card_array, hide_subsequent = false)
  card_array = if hide_subsequent
                 card_array.map.with_index do |card, index|
                   index.zero? ? card[1].capitalize : 'unknown card'
                 end
               else
                 card_array.map { |card| card[1].capitalize }
               end

  return card_array.join(' and ') if card_array.size < 3

  card_array[0..-2].join(', ') + ', and ' + card_array[-1]
end

def display_hands(participants, show_all = false)
  clear_terminal
  participants.each do |name, attributes|
    if !attributes[:user_controlled] && show_all == false
      prompt "#{name.to_s.capitalize} has: "\
             "#{list_cards(attributes[:hand], true)}"
    else
      prompt "#{name.to_s.capitalize} has: #{list_cards(attributes[:hand])}"
    end
  end
end

def hit?
  loop do
    puts ''
    prompt 'Do you want to hit or stay? (h or s)'
    answer = gets.chomp.downcase
    return true if answer.start_with?('h')
    return false if answer.start_with?('s')

    prompt 'Invalid input.'
  end
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

def display_results(participants)
  clear_terminal
  puts "=============="
  participants.each do |name, attributes|
    prompt "#{name.capitalize} has #{list_cards(attributes[:hand])}, "\
           "for a total of: #{attributes[:score]}"
    prompt "#{name.capitalize} Bust!" if attributes[:bust]
  end
  puts "=============="
  puts ''
end

def continue_playing?
  loop do
    puts ''
    prompt 'Would you like to continue playing? (y or n)'
    answer = gets.chomp.downcase
    return true if answer.start_with?('y')
    return false if answer.start_with?('n')

    prompt 'Invalid input'
  end
end

clear_terminal
prompt "Welcome to Twenty-one! The player with the most points without going "\
       "over the target number wins!"
prompt "The target number for this game is #{TARGET_NUMBER}. "\
       "If you go over #{TARGET_NUMBER}, you lose."
wait_for_user

# Each cards is an array with index 0 as the suit and index 1 as the rank.
ALL_CARDS = create_deck(SUIT_NAMES).freeze

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

    # Deal starting cards
    2.times do
      participants.each do |_, attributes|
        deal_card!(deck, attributes[:hand], discard_pile)
        update_score!(attributes)
      end
    end

    # Begin play
    loop do
      display_hands(participants)

      # Participant's turns
      participants.each do |_, attributes|
        unless attributes[:stayed]
          if !attributes[:user_controlled] && attributes[:score] < (TARGET_NUMBER - 4) ||
             attributes[:user_controlled] && hit?
            deal_card!(deck, attributes[:hand], discard_pile)
            update_score!(attributes)
          else
            attributes[:stayed] = true
          end

          convert_ace_if_needed!(attributes)

          if attributes[:score] > TARGET_NUMBER
            attributes[:bust] = true
            break
          end
        end
      end
      break if participants.all? { |_, attributes| attributes[:stayed] } ||
               participants.any? { |_, attributes| attributes[:bust] }
    end

    display_hands(participants)

    # Display Winner
    display_results(participants)

    winner = get_result(participants)
    if games_won.key?(winner)
      games_won[winner] += 1
      prompt "#{winner.capitalize} wins!"
    else
      prompt "Tie!"
    end

    # Display games won
    puts ''
    games_won.each do |participant, won|
      prompt "#{participant.capitalize}: #{won}"
    end

    wait_for_user

    participants.each { |_, attributes| discard_pile << attributes[:hand] }

    break if games_won.any? { |_, won| won == 5 }
  end

  clear_terminal
  games_won.each do |participant, won|
    prompt "#{participant.capitalize} won 5 games!" if won == 5
  end

  break unless continue_playing?
end

prompt 'Thank you for playing! Goodbye!'
