module UIControl
  def clear_terminal
    system 'clear'
  end

  def wait_for_input
    puts
    puts 'Press enter to continue.'
    gets
    clear_terminal
  end
end

module RPSSLRules
  # rubocop:disable Layout/LineLength
  def game_rules
    "Rock Paper Scissors Spock Lizard is a variation of the classic Rock Paper Scissors game but there are now 5 choices instead of 3. In each round, two players each choose a move which are then compared. Every move chosen is able to beat two other moves as well as be beaten by two other moves. The rules for the winner of each pairing will be as follows: " \
    "\n" \
    "\nRock beats Lizard and Scissors" \
    "\nPaper beats Rock and Spock" \
    "\nScissors beats Paper and Lizard" \
    "\nSpock beats Scissors and Rock" \
    "\nLizard beats Spock and Paper" \
    "\n" \
    "\nIf both players choose the same move, no points are awarded. Otherwise the winner of the pairing is awarded 1 point. Once a player obtains a number of points equal to the chosen target number, that player is declared the grand winner."
  end
  # rubocop:enable Layout/LineLength

  def display_rules
    clear_terminal
    puts game_rules
    wait_for_input
  end
end

class Move
  VALUES = {
    1 => 'Rock',
    2 => 'Paper',
    3 => 'Scissors',
    4 => 'Spock',
    5 => 'Lizard'
  }

  def initialize(number)
    @value = VALUES[number]
  end

  def rock?
    self.class == Rock
  end

  def paper?
    self.class == Paper
  end

  def scissors?
    self.class == Scissors
  end

  def spock?
    self.class == Spock
  end

  def lizard?
    self.class == Lizard
  end

  def to_s
    @value
  end
end

class Rock < Move
  def >(other_move)
    other_move.lizard? || other_move.scissors?
  end
end

class Paper < Move
  def >(other_move)
    other_move.rock? || other_move.spock?
  end
end

class Scissors < Move
  def >(other_move)
    other_move.paper? || other_move.lizard?
  end
end

class Spock < Move
  def >(other_move)
    other_move.scissors? || other_move.rock?
  end
end

class Lizard < Move
  def >(other_move)
    other_move.spock? || other_move.paper?
  end
end

class Player
  attr_accessor :score, :data_to_view
  attr_reader :name, :move

  include UIControl

  MAX_NAME_LENGTH = 16

  def initialize
    set_name
    @score = 0
    @data_to_view = nil
  end

  def self.new_cpu
    cpu_class = [R2D2, Hal, Chappie, Sonny, Number5].sample
    cpu_class.new
  end

  private

  attr_writer :name, :move

  def create_move(choice)
    self.move = case choice
                when 1 then Rock.new(choice)
                when 2 then Paper.new(choice)
                when 3 then Scissors.new(choice)
                when 4 then Spock.new(choice)
                when 5 then Lizard.new(choice)
                end
  end
end

class Human < Player
  def choose
    choice = nil
    loop do
      choice = request_choice
      check_for_view_request(choice)
      return if data_to_view

      choice = convert_to_number(choice)
      break if choice_valid?(choice)

      puts "Sorry, invalid choice."
    end
    create_move(choice)
  end

  private

  def set_name
    clear_terminal
    player_name = ''
    loop do
      puts "What's your name? (max: #{MAX_NAME_LENGTH} characters)"
      player_name = gets.chomp.strip
      break unless player_name.empty? || player_name.size > MAX_NAME_LENGTH

      puts "Sorry, must enter a value."
    end
    self.name = player_name
  end

  def request_choice
    puts "Enter 'r' to view the rules. Enter 'v' to view all previous moves."
    puts
    puts "Enter Rock(1), Paper(2), Scissors(3), Spock(4), Lizard(5) " \
         "to select a move."
    gets.chomp
  end

  def check_for_view_request(choice)
    if choice.downcase == 'v'
      self.data_to_view = :all_moves
    elsif choice.downcase == 'r'
      self.data_to_view = :rules
    end
  end

  def convert_to_number(choice)
    choice = choice.capitalize
    choice = Move::VALUES.key(choice) if Move::VALUES.value?(choice)
    choice.to_i
  end

  def choice_valid?(choice)
    valid_numbers = Move::VALUES.keys.to_a
    valid_numbers.include?(choice)
  end
end

class Computer < Player
  def choose
    choice = cpu_choice_number
    create_move(choice)
  end
end

class R2D2 < Computer
  private

  def set_name
    self.name = 'R2D2'
  end

  def cpu_choice_number
    1
  end
end

class Hal < Computer
  private

  def set_name
    self.name = 'Hal'
  end

  def cpu_choice_number
    case (0...100).to_a.sample
    when 0...5 then 1
    when 5...70 then 3
    when 70...85 then 4
    when 85...100 then 5
    end
  end
end

class Chappie < Computer
  private

  def set_name
    self.name = 'Chappie'
  end

  def cpu_choice_number
    [1, 2, 3].sample
  end
end

class Sonny < Computer
  private

  def set_name
    self.name = 'Sonny'
  end

  def cpu_choice_number
    case (0...100).to_a.sample
    when 0...5 then 1
    when 5...10 then 2
    when 10...15 then 3
    when 15...95 then 4
    when 95...100 then 5
    end
  end
end

class Number5 < Computer
  private

  def set_name
    self.name = 'Number 5'
  end

  def cpu_choice_number
    Move::VALUES.keys.sample
  end
end

# Game Orchestration Engine
class RPSSLGame
  include RPSSLRules, UIControl

  MAX_NAME_LENGTH = Player::MAX_NAME_LENGTH
  ALL_MOVES_LENGTH = (MAX_NAME_LENGTH * 3) + 10

  MAX_TARGET_SCORE = 10

  def initialize
    @human = Human.new
    @computer = Player.new_cpu
    @all_moves = {}
    @current_game = 0
  end

  def play
    welcome_user

    loop do
      setup_new_game
      core_gameplay_loop until player_won?
      break unless play_again?
      reset_score
    end
    display_goodbye_message
  end

  private

  attr_accessor :target_score, :current_game, :winner, :grand_winner
  attr_reader :all_moves, :human, :computer

  # Game Logic
  def welcome_user
    display_welcome_message
    loop do
      puts "Enter 'r' to view the rules or enter 'p' to play!"
      choice = gets.chomp.downcase

      case choice
      when 'p', 'play'  then break
      when 'r', 'rules' then display_rules
      else puts "Sorry, invalid choice."
      end
    end
  end

  def setup_new_game
    choose_target_score
    self.current_game += 1

    all_moves[current_game] = {
      :game_num => current_game,
      human.name => [],
      computer.name => [],
      :winners => [],
      :grand_winner => nil
    }
  end

  def choose_target_score
    answer = nil
    loop do
      puts "How many points do you want to play up to? " \
           "(min: 1, max: #{MAX_TARGET_SCORE})"
      answer = gets.chomp
      break if answer.to_i > 0 && answer.to_i < MAX_TARGET_SCORE

      puts "Please choose a target score between 1 and #{MAX_TARGET_SCORE}."
    end
    self.target_score = answer.to_i
  end

  def core_gameplay_loop
    loop do
      display_scoreboard
      human.choose
      break unless human.data_to_view

      display_rules if human.data_to_view == :rules
      display_all_moves if human.data_to_view == :all_moves
      human.data_to_view = nil
    end

    computer.choose
    establish_winner
  end

  def establish_winner
    self.winner = human if human.move > computer.move
    self.winner = computer if computer.move > human.move

    update_score
    display_scoreboard
    display_move
    display_winner
    add_to_all_moves
    self.winner = nil
  end

  def update_score
    winner.score += 1 if winner
  end

  def add_to_all_moves
    [human, computer].each do |player|
      all_moves[current_game][player.name] << player.move
    end

    add_to_previous_winners
  end

  def add_to_previous_winners
    all_moves[current_game][:winners] << (winner.nil? ? 'Tie!' : winner.name)
  end

  def play_again?
    answer = 'view'
    loop do
      display_grand_winner if answer == 'v' || answer == 'view'
      print_play_again_options
      answer = gets.chomp.downcase

      answer = interpret_play_again_response(answer)

      break if answer == true || answer == false
    end

    answer
  end

  def interpret_play_again_response(answer)
    case answer
    when 'p', 'play' then return true
    when 'q', 'quit' then return false

    when 'v', 'view' then display_all_moves
    else puts 'Invalid choice. Please enter one of the listed options.'
    end
    answer
  end

  def player_won?
    [human, computer].each do |player|
      if player.score == target_score
        self.grand_winner = player
        all_moves[current_game][:grand_winner] = player.name
        return true
      end
    end

    false
  end

  def reset_score
    [human, computer].each { |player| player.score = 0 }
  end

  # Display Methods
  def display_welcome_message
    clear_terminal
    puts "Welcome to Rock, Paper, Scissors, Spock, Lizard!"
    puts
  end

  def display_scoreboard
    clear_terminal
    print_scoreboard_seperator
    print_scoreboard_line(human.name, computer.name)
    print_scoreboard_seperator
    print_scoreboard_line(human.score.to_s, computer.score.to_s)
    print_scoreboard_seperator
    puts
  end

  def print_scoreboard_seperator
    middle = '-' * MAX_NAME_LENGTH
    puts "+-#{middle}---#{middle}-+"
  end

  def print_scoreboard_line(string1, string2)
    puts "| #{string1.center(MAX_NAME_LENGTH)} " \
         "| #{string2.center(MAX_NAME_LENGTH)} |"
  end

  def display_all_moves
    clear_terminal

    all_moves.each do |game_num, attributes|
      display_all_moves_header(game_num)
      display_all_moves_body(attributes)
      print_all_moves_seperator
      display_all_moves_footer(attributes) if attributes[:grand_winner]
      puts
    end

    wait_for_input
  end

  def display_all_moves_header(game_num)
    title_string = "Game #{game_num}"

    print_all_moves_top
    print_all_moves_title(title_string)
    print_all_moves_seperator
    print_all_moves_line2(human.name, computer.name, 'Winner')
    print_all_moves_seperator
  end

  def print_all_moves_top
    puts "+#{('-' * ALL_MOVES_LENGTH)}+"
  end

  def print_all_moves_title(string)
    puts '|' + string.center(ALL_MOVES_LENGTH) + '|'
  end

  def print_all_moves_seperator
    middle = '-' * MAX_NAME_LENGTH
    puts "+-#{middle}-----#{middle}-+-#{middle}-+"
  end

  def print_all_moves_line2(str1, str2, str3)
    puts "| #{str1.ljust(MAX_NAME_LENGTH)} vs. " \
         "#{str2.ljust(MAX_NAME_LENGTH)} | #{str3.ljust(MAX_NAME_LENGTH)} |"
  end

  def display_all_moves_body(attributes)
    attributes[:winners].each_with_index do |round_winner, index|
      move1 = attributes[human.name][index].to_s
      move2 = attributes[computer.name][index].to_s
      print_all_moves_line2(move1, move2, round_winner)
    end
  end

  def display_all_moves_footer(attributes)
    grand_winner_string = "Grand Winner: #{attributes[:grand_winner]}!"
    print_all_moves_title(grand_winner_string)
    print_all_moves_top
  end

  def display_move
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    puts
  end

  def display_winner
    if winner
      puts "#{winner.name} won!"
    else
      puts "It's a tie!"
    end

    wait_for_input
  end

  def display_grand_winner
    size = MAX_NAME_LENGTH + 24

    puts "*#{'*' * size}*"
    puts "*#{' ' * size}*"
    puts '*' + "#{grand_winner.name} is the Grand Winner!".center(size) + '*'
    puts "*#{' ' * size}*"
    puts "*#{'*' * size}*"
    puts
  end

  def print_play_again_options
    puts "Enter 'p' to play again, enter 'q' to quit"
    puts
    puts "(Or enter 'v' to view all the moves made in previous rounds)"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Spock, Lizard. Good Bye!"
  end
end

RPSSLGame.new.play
