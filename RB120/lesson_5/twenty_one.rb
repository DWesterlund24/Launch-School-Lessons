module InputFromUser
  def request_string_of_size(question, range, error_message=nil)
    answer = nil
    loop do
      puts question
      answer = gets.strip
      break if range.include?(answer.size)
      print_error_message(error_message, range)
    end
    answer
  end

  def request_number(question, range, error_message=nil)
    answer = nil
    loop do
      puts question
      answer = gets.strip
      break if answer.to_i.to_s == answer && range.include?(answer.to_i)
      print_error_message(error_message, range)
    end
    answer.to_i
  end

  def multiple_choice(question, options)
    answer = nil
    loop do
      display_multi_choice_options(question, options)
      answer = gets.strip
      valid_answers = (1..options.size)
      break if string_an_int?(answer) && valid_answers.include?(answer.to_i)
      print_error_message
    end
    options[answer.to_i - 1]
  end

  def display_multi_choice_options(question, options)
    puts question
    puts
    options.each_with_index do |option, index|
      puts "    #{index + 1}) #{option}"
    end
    puts
  end

  def print_error_message(error_message=nil, validator=nil)
    error_message ||= generate_generic_error
    puts error_message
  end

  def generate_generic_error
    "Invalid input."
  end

  def string_an_int?(string)
    string.to_i.to_s == string
  end
end

module UIControl
  def clear_ui
    system 'clear'
  end

  def wait_for_input
    puts
    puts "Press enter to continue."
    gets
  end
end

class Participant
  attr_accessor :score
  attr_reader :hand, :stayed, :name

  def initialize(deck, settings)
    @deck = deck
    @settings = settings
    @hand = []
    @score = 0
    @stayed = false
  end

  def [](index)
    hand[index]
  end

  def hit
    deck.deal(self)
  end

  def stay
    self.stayed = true
  end

  def bust?
    total_value > target_number
  end

  def natural?
    hand.size == 2 && total_value == target_number
  end

  def reset_and_discard
    hand.each { |card| deck.discards << card }

    self.hand = []
    self.stayed = false
  end

  def total_value
    values = hand.map(&:value)

    if values.sum > target_number
      values = convert_aces_to_ones(values, target_number)
    end

    values.sum
  end

  private

  def target_number
    settings.target_number
  end

  def convert_aces_to_ones(values, target_number)
    until !values.include?(11)
      ace_index = values.index(11)
      values[ace_index] = 1
      break if values.sum <= target_number
    end

    values
  end

  attr_writer :hand, :stayed
  attr_reader :deck, :settings
end

class Player < Participant
  include InputFromUser

  def new_name
    question = 'What is your name?'
    acceptable_name_length = (1..16)
    error_msg = "Invalid input. Name must be between 1 and 16 characters."

    @name = request_string_of_size(question, acceptable_name_length, error_msg)
  end
end

class Dealer < Participant
  def new_name
    @name = 'Dealer'
  end
end

class Deck
  SUITS = [:hearts, :clubs, :diamonds, :spades]
  RANKS = [:ace, 2, 3, 4, 5, 6, 7, 8, 9, 10, :jack, :queen, :king]

  attr_reader :discards

  def initialize(number_of_decks=1)
    @undrawn_cards = []
    @discards = []
    reset(number_of_decks)
  end

  def reset(number_of_decks)
    self.undrawn_cards = []
    number_of_decks.times do
      SUITS.each do |suit|
        RANKS.each { |rank| undrawn_cards << Card.new(suit, rank) }
      end
    end
    undrawn_cards.shuffle!
  end

  def deal(recipient)
    if undrawn_cards.empty?
      self.undrawn_cards = discards.shuffle
      self.discards = []
    end

    recipient.hand << undrawn_cards.shift
  end

  private

  attr_accessor :undrawn_cards
  attr_writer :discards
end

class Card
  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{rank.to_s.capitalize} of #{suit.to_s.capitalize}"
  end

  alias name to_s

  def value
    case rank
    when :ace                 then 11
    when :king, :queen, :jack then 10
    else                           rank
    end
  end

  private

  attr_reader :suit, :rank
end

class Table
  TOTAL_WIDTH = 39
  SIDE_TOTAL_WIDTH = 19
  SIDE_CONTENTS_WIDTH = 17

  def initialize(player, dealer)
    @player = player
    @dealer = dealer
  end

  private

  attr_reader :player, :dealer

  def display_border1
    puts "+#{'-' * TOTAL_WIDTH}+"
  end

  def display_border2
    puts "+#{'-' * SIDE_TOTAL_WIDTH}+#{'-' * SIDE_TOTAL_WIDTH}+"
  end

  def display_title(title)
    puts "|#{title.center(TOTAL_WIDTH)}|"
  end

  def display_names
    display_content_line_centered(player.name, dealer.name)
  end

  def display_content_line_centered(left_string, right_string)
    puts "| #{left_string.to_s.center(SIDE_CONTENTS_WIDTH)} " \
         "| #{right_string.to_s.center(SIDE_CONTENTS_WIDTH)} |"
  end
end

class GameTable < Table
  def show_hands(reveal_all=false)
    display_border1
    display_title("Player's Hands")
    display_border2
    display_names
    display_border2
    display_hands(reveal_all)
    display_border2
    display_totals(reveal_all)
    display_border2
  end

  private

  def display_hands(reveal_all)
    biggest_hand_size = [player.hand.size, dealer.hand.size].max

    biggest_hand_size.times do |index|
      player_card = player.hand[index]

      dealer_card = dealer.hand[index]
      unless dealer_card.nil? || reveal_all || index.zero?
        dealer_card = 'Unknown Card'
      end

      display_content_line_centered(player_card, dealer_card)
    end
  end

  def display_totals(reveal_all)
    player_total = player.total_value.to_s
    dealer_total = if reveal_all
                     dealer.total_value.to_s
                   else
                     '?'
                   end

    display_content_line_centered(player_total, dealer_total)
  end
end

class ScoreBoard < Table
  def show_scores
    display_border1
    display_title('Score Board')
    display_border2
    display_names
    display_border2
    display_score_line
    display_border2
    puts
  end

  private

  def display_score_line
    display_content_line_centered(player.score, dealer.score)
  end
end

class TwentyOneSettings
  include UIControl, InputFromUser

  DEFAULT_TARGET_NUMBER = 21
  DEFAULT_NUMBER_OF_DECKS = 1
  DEFAULT_TARGET_SCORE = 5
  MAIN_SETTINGS_OPTIONS = ['Change Target Number', 'Change Number of Decks Used',
                           'Change Target Score', 'Reset to Default Settings',
                           'Confirm Settings']

  attr_reader :target_number, :number_of_decks, :target_score

  def initialize
    reset_settings_to_default
  end

  def display
    puts <<-SETTINGS
This game has a target number of #{target_number} and uses #{number_of_decks} #{number_of_decks == 1 ? 'deck' : 'decks'} of cards.
The first player to reach #{target_score} wins is the grand winner.

    SETTINGS
  end

  def update
    loop do
      clear_ui
      display

      question = "What would you like to do?"
      options = MAIN_SETTINGS_OPTIONS
      answer = multiple_choice(question, options)
      break if answer == 'Confirm Settings'

      determine_setting_to_change(answer)
    end
  end

  private

  attr_writer :target_number, :number_of_decks, :target_score

  def reset_settings_to_default
    @target_number = DEFAULT_TARGET_NUMBER
    @number_of_decks = DEFAULT_NUMBER_OF_DECKS
    @target_score = DEFAULT_TARGET_SCORE
  end

  def determine_setting_to_change(answer)
    case answer
    when 'Change Target Number' then change_target_number
    when 'Change Number of Decks Used' then change_number_of_decks
    when 'Change Target Score' then change_target_score
    when 'Reset to Default Settings' then reset_settings_to_default
    end
  end

  def change_target_number
    range = 21..100
    question = "Please enter a new target number" \
               "(min: #{range.min}, max: #{range.max}, " \
               "default: #{DEFAULT_TARGET_NUMBER})"

    answer = request_number(question, range)
    self.target_number = answer
  end

  def change_number_of_decks
    range = 1..10
    question = "How many decks would you like to use?" \
               "(min: #{range.min}, max: #{range.max}, " \
               "default: #{DEFAULT_NUMBER_OF_DECKS})"

    answer = request_number(question, range)
    self.number_of_decks = answer
  end

  def change_target_score
    range = 1..100
    question = "Please enter a new target score" \
               "(min: #{range.min}, max: #{range.max}, " \
               "default: #{DEFAULT_TARGET_SCORE})"

    answer = request_number(question, range)
    self.target_score = answer
  end
end

class TwentyOneGame
  include UIControl, InputFromUser

  def initialize
    @settings = TwentyOneSettings.new
    @deck = Deck.new
    setup_players
    setup_tables
  end

  def start
    display_welcome
    setup_new_game
    loop do
      play_round
      break unless play_again?
      reset_scores
    end
    display_farewell
  end

  private

  attr_reader :player, :dealer, :deck, :participants, :settings, :game_table,
              :scoreboard, :turn_timeline

  def setup_players
    @player = Player.new(deck, settings)
    @dealer = Dealer.new(deck, settings)
    @participants = [player, dealer]
    @turn_timeline = participants.dup
  end

  def setup_tables
    @scoreboard = ScoreBoard.new(player, dealer)
    @game_table = GameTable.new(player, dealer)
  end

  def target_number
    settings.target_number
  end

  def target_score
    settings.target_score
  end

  def display_welcome
    clear_ui
    puts <<-WELCOME
Welcome to Twenty-One!

In Twenty-One each player begins with a hand of two random cards. A player's points will be the sum of the values attributed to these cards. All number cards have the value of their number and all face cards are worth 10 points. Aces are worth 11 points but change their value to 1 point if the holder's total points is over the target number. Each turn, each player may either "hit", drawing another card and adding its value to their points, or "stay", locking in their points for the rest of the round. The goal of the game is to obtain a higher point total than the opponent without going over the target number(21 by default), any point total over this target is a "bust", an automatic loss giving the opponent the win. The player can also get an automatic win by drawing a "natural", which is when their first two cards combined values are equal to the target number.
    WELCOME
    wait_for_input
  end

  def setup_new_game
    set_participant_names
    settings.display
    confirm_or_change_settings
    deck.reset(settings.number_of_decks)
  end

  def set_participant_names
    clear_ui
    participants.each(&:new_name)
  end

  def confirm_or_change_settings
    answer = nil

    until answer == 'Start game'
      clear_ui
      settings.display

      question = "What would you like to do?"
      valid_answers = ['Start game', 'Change settings']
      answer = multiple_choice(question, valid_answers)

      settings.update if answer == 'Change settings'
    end
  end

  def play_round
    until participants.any? { |participant| participant.score == target_score }
      setup_new_round
      take_turns
      declare_winner
    end
    declare_grand_winner
  end

  def setup_new_round
    participants.each(&:reset_and_discard)
    turn_timeline.rotate! until turn_timeline.first == player
    deal_starting_cards
    show_score_and_cards
  end

  def deal_starting_cards
    2.times do
      participants.each { |participant| deck.deal(participant) }
    end

    display_starting_cards_messages
  end

  def display_starting_cards_messages
    show_score_and_cards
    puts "#{player.name} drew the #{player[0]} and the #{player[1]}."
    puts "#{dealer.name} drew the #{dealer[0]} and another card."
    wait_for_input
  end

  def show_score_and_cards(reveal_all: false)
    clear_ui
    scoreboard.show_scores
    game_table.show_hands(reveal_all)
    puts
  end

  def take_turns
    return if player.natural?

    until participants.all?(&:stayed)
      active_player = turn_timeline.first

      unless active_player.stayed
        hit_or_stay(active_player)
        display_last_move(active_player)
        break if active_player.bust?
      end

      turn_timeline.rotate!
    end
  end

  def hit_or_stay(active_player)
    user_hit_or_stay(active_player) if active_player.class == Player
    computer_hit_or_stay(active_player) if active_player.class == Dealer
  end

  def user_hit_or_stay(active_player)
    show_score_and_cards
    question = 'Would you like to Hit or Stay?'
    choices = ['Hit', 'Stay']
    answer = multiple_choice(question, choices)

    if answer == 'Hit'
      active_player.hit
    elsif answer == 'Stay'
      active_player.stay
    end
  end

  def computer_hit_or_stay(active_player)
    if active_player.total_value < target_number - 4
      active_player.hit
    else
      active_player.stay
    end
  end

  def display_last_move(active_player)
    if player.stayed
      show_score_and_cards(reveal_all: true)
    else
      show_score_and_cards
    end

    message = last_move_message(active_player)
    return if message.nil?

    puts message
    wait_for_input
  end

  def last_move_message(active_player)
    if active_player == player
      player_last_move_message
    elsif active_player == dealer
      dealer_last_move_message
    end
  end

  def player_last_move_message
    if player.stayed && dealer.stayed
      "You stayed."
    elsif player.stayed
      "You stayed. The dealer shows their cards as they continue."
    else
      "You drew the #{player[-1]}." unless player.stayed
    end
  end

  def dealer_last_move_message
    if dealer.stayed
      "#{dealer.name} stayed."
    elsif player.stayed
      "#{dealer.name} drew the #{dealer[-1]}."
    else
      "#{dealer.name} drew a card."
    end
  end

  def declare_winner
    winner = (player.natural? ? player : determine_winner)

    increment_score(winner)
    announce_winner(winner)
  end

  def determine_winner
    winning_value = participants.map(&:total_value).max
    winner = participants.select do |participant|
      participant.total_value == winning_value
    end

    winner = (winner.size == 1 ? winner.first : :tie)
    if winner != :tie && winner.bust?
      winner = participants.reject { |participant| participant == winner }[0]
    end

    winner
  end

  def increment_score(winner)
    winner.score += 1 unless winner == :tie
  end

  def announce_winner(winner)
    show_score_and_cards(reveal_all: true)
    display_final_scores

    if winner == :tie
      puts "It's a tie!"
    elsif winner == player && player.natural?
      puts "Natural #{target_number}! #{winner.name} wins!"
    else
      puts "#{winner.name} wins!"
    end

    wait_for_input
  end

  def display_final_scores
    msg = ''
    participants.each do |participant|
      msg << if participant.bust?
               "#{participant.name} bust. "
             else
               "#{participant.name} has #{participant.total_value} points. "
             end
    end

    puts msg
  end

  def declare_grand_winner
    grand_winner = participants.select do |participant|
      participant.score == target_score
    end.first

    clear_ui
    show_grand_winner(grand_winner)
    wait_for_input
  end

  def show_grand_winner(grand_winner)
    puts '*' * 41
    puts "*#{' ' * 39}*"
    puts "*#{(grand_winner.name + ' is the Grand Winner!').center(39)}*"
    puts "*#{' ' * 39}*"
    puts '*' * 41
  end

  def play_again?
    question = "Would you like to play another match?"
    choices = ['Yes', 'No']
    answer = multiple_choice(question, choices)

    return unless answer == 'Yes'

    settings.update unless keep_settings?
    true
  end

  def keep_settings?
    clear_ui
    question = "Would you like to play another game with the same settings? " \
               "Or would you like to change the settings?"
    choices = ['Keep current settings', 'Change settings']
    answer = multiple_choice(question, choices)

    answer == 'Keep current settings'
  end

  def reset_scores
    participants.each { |participant| participant.score = 0 }
  end

  def display_farewell
    puts "Thanks for playing Twenty-One! Goodbye!"
  end
end

TwentyOneGame.new.start
