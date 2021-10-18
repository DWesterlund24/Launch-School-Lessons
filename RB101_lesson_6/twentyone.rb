CARDS_IN_SUIT = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                  '8' => 8, '9' => 9, '10' => 10, 'jack' => 10, 'queen' => 10,
                  'king' => 10, 'ace' => 11 }

TARGET_NUMBER = 27

def prompt(string)
  puts('=> ' + string)
end

# Argument is an array of characters
# Each character in the array represents a suit and is prepended to each card name
def create_deck(array)
  array.each_with_object({}) do |char, object|
    suit = CARDS_IN_SUIT.map do |key, value|
      [char + key, value]
    end.to_h

    object.merge!(suit)
  end
end

def deal_card!(deck, hand, discards)
  # Shuffle discards into deck as necessary
  if deck.empty?
    (deck << discards.dup).flatten!
    discards.clear
  end

  random_card = deck.sample
  hand << random_card
  deck.delete(random_card)
end

# Returns string of card names without suit characters
def list_cards(card_array, hide_subsequent = false)
  if hide_subsequent == true
    card_array = card_array.map.with_index do |card, index|
      index > 0 ? 'unknown card' : card[1..].capitalize
    end
  else
    card_array = card_array.map { |card| card[1..].capitalize }
  end

  return card_array.join(' and ') if card_array.size < 3
  card_array[0..-2].join(', ') + ', and ' + card_array[-1]
end

def display_hands(player_hand, dealer_hand, show_all = false)
  puts ''
  if show_all == false
    prompt "Dealer has: #{list_cards(dealer_hand, true)}"
  else
    prompt "Dealer has: #{list_cards(dealer_hand)}"
  end

  prompt "Player has: #{list_cards(player_hand)}"
end

def hit_or_stay?
  loop do
    prompt 'Do you want to hit or stay? (h or s)'
    answer = gets.chomp.downcase
    return answer if answer.start_with?('h', 's')

    prompt 'Invalid input.'
  end
end

def last_card_value(hand, total, ace_count)
  last_card_value = ALL_CARDS[hand[-1]]
  total += last_card_value

  ace_count += 1 if last_card_value == 11
  [total, ace_count]
end

def convert_ace_if_needed(total, ace_tally)
  loop do
    if total > TARGET_NUMBER && ace_tally.positive?
      total -= 10
      ace_tally -= 1
    else
      break
    end
  end
  [total, ace_tally]
end

def get_result(player_score, dealer_score)
  return :player if player_score > dealer_score
  return :dealer if dealer_score > player_score
  :tie
end

def display_results(player_hand, player_score, dealer_hand, dealer_score)
  puts ''
  puts "=============="
  prompt "Dealer has #{list_cards(dealer_hand)}, for a total of: #{dealer_score}"
  prompt "Player has #{list_cards(player_hand)}, for a total of: #{player_score}"
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

prompt "Welcome to Twenty-one! The player with the most points wins!"
prompt "But be careful, If you go over #{TARGET_NUMBER}, you lose."

# Cards will be strings with the first character signifying suit
# h5 => 5 of hearts, sking => King of spades, etc.
ALL_CARDS = create_deck(['c', 'd', 'h', 's']).freeze

deck = ALL_CARDS.keys
discard_pile = []

loop do
  player_games_won = 0
  dealer_games_won = 0

  until player_games_won >= 5 || dealer_games_won >= 5
    player_hand = []
    dealer_hand = []

    player_score = 0
    dealer_score = 0

    player_ace_count = 0
    dealer_ace_count = 0

    2.times do
      deal_card!(deck, player_hand, discard_pile)
      player_score, player_ace_count = last_card_value(player_hand, player_score, player_ace_count)

      deal_card!(deck, dealer_hand, discard_pile)
      dealer_score, dealer_ace_count = last_card_value(dealer_hand, dealer_score, dealer_ace_count)
    end

    player_bust = false
    dealer_bust = false

    player_stayed = false
    dealer_stayed = false

    loop do
      display_hands(player_hand, dealer_hand)

      # Player turn
      unless player_stayed
        if hit_or_stay?.downcase.start_with?('h')
          deal_card!(deck, player_hand, discard_pile)
          player_score, player_ace_count = last_card_value(player_hand, player_score, player_ace_count)
        else
          player_stayed = true
        end
      end

      player_score, player_ace_count = convert_ace_if_needed(player_score, player_ace_count)

      if player_score > TARGET_NUMBER
        player_bust = true
        break
      end

      # Dealer turn
      unless dealer_stayed
        if dealer_score < (TARGET_NUMBER - 4)
          deal_card!(deck, dealer_hand, discard_pile)
          dealer_score, dealer_ace_count = last_card_value(dealer_hand, dealer_score, dealer_ace_count)
        else
          dealer_stayed = true
        end
      end

      dealer_score, dealer_ace_count = convert_ace_if_needed(dealer_score, dealer_ace_count)

      if dealer_score > TARGET_NUMBER
        dealer_bust = true
        break
      end

      break if player_stayed && dealer_stayed
    end

    display_hands(player_hand, dealer_hand, true)

    # Display Winner
    display_results(player_hand, player_score, dealer_hand, dealer_score)

    if player_bust
      prompt "Player bust, Dealer wins!"
      dealer_games_won += 1
    elsif dealer_bust
      prompt "Dealer bust, Player wins!"
      player_games_won += 1
    else
      case get_result(player_score, dealer_score)
      when :player
        prompt "Player wins!"
        player_games_won += 1
      when :dealer
        prompt "Dealer wins!"
        dealer_games_won += 1
      when :tie
        prompt "Tie!"
      end
    end

    prompt "Player: #{player_games_won}, Dealer: #{dealer_games_won}"
  end

  if player_games_won >= 5
    puts "You won! Congratulations!"
  else
    puts "Dealer won."
  end

  break unless continue_playing?

  discard_pile << player_hand + dealer_hand
end

prompt 'Thank you for playing! Good bye!'
