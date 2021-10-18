CARDS_IN_SUIT = { '2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7,
                  '8' => 8, '9' => 9, '10' => 10, 'jack' => 10, 'queen' => 10,
                  'king' => 10, 'ace' => 11 }

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

def add_up_hand(hand)
  # Get card values
  total = hand.each_with_object([]) do |card, score|
    score << ALL_CARDS[card]
  end

  # Convert Aces value to 1 as necessary
  loop do
    if total.sum > 21
      total[total.index(11)] = 1 if total.any?(11)
    end

    break if total.sum < 22 || total.none?(11)
  end

  total.sum
end

def distinguish_winner(player_hand, dealer_hand)
  player_score = add_up_hand(player_hand)
  dealer_score = add_up_hand(dealer_hand)

  return 'Player wins!' if player_score > dealer_score
  return 'Dealer wins!' if dealer_score > player_score
  'Tie game!'
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
prompt "But be careful, If you go over 21, you lose."

# Cards will be strings with the first character signifying suit
# h5 => 5 of hearts, sking => King of spades, etc.
ALL_CARDS = create_deck(['c', 'd', 'h', 's']).freeze

deck = ALL_CARDS.keys
discard_pile = []

loop do
  player_hand = []
  dealer_hand = []

  2.times do
    deal_card!(deck, player_hand, discard_pile)
    deal_card!(deck, dealer_hand, discard_pile)
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
      else
        player_stayed = true
      end
    end

    if add_up_hand(player_hand) > 21
      player_bust = true
      break
    end

    # Dealer turn
    unless dealer_stayed
      if add_up_hand(dealer_hand) < 17
        deal_card!(deck, dealer_hand, discard_pile)
      else
        dealer_stayed = true
      end
    end

    if add_up_hand(dealer_hand) > 21
      dealer_bust = true
      break
    end

    break if player_stayed && dealer_stayed
  end

  display_hands(player_hand, dealer_hand, true)

  # Display Winner
  puts ''
  prompt "Player: #{add_up_hand(player_hand)}, Dealer: #{add_up_hand(dealer_hand)}"

  if player_bust
    prompt "Player bust, Dealer wins!"
  elsif dealer_bust
    prompt "Dealer bust, Player wins!"
  else
    prompt distinguish_winner(player_hand, dealer_hand)
  end

  break unless continue_playing?

  discard_pile << player_hand + dealer_hand
end

prompt 'Thank you for playing! Good bye!'
