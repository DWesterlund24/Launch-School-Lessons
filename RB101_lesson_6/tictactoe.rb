require 'pry-byebug'

WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columnns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

def prompt(string)
  puts '=> ' + string
end

def joinor(array, delimiter = ', ', last_delimiter = 'or')
  array = array.map(&:to_s)
  array[-1].prepend(last_delimiter + ' ') if array.size > 1
  array.size > 2 ? array.join(delimiter) : array.join(' ')
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is a #{COMPUTER_MARKER}."
  puts ''
  puts '     |     |'
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts '     |     |'
  puts '-----+-----+-----'
  puts '     |     |'
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts '     |     |'
  puts ''
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Chosse a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break
    else
      prompt "Sorry, that's not a valid choice"
    end
  end
  brd[square] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  threatened_lines = find_threatened_lines(brd).flatten
  winning_moves = find_check_mate(brd).flatten

  square = empty_squares(brd).intersection(winning_moves).sample # Attack
  square = empty_squares(brd).intersection(threatened_lines).sample if square.nil? # Defend
  square = 5 if empty_squares(brd).any?(5) && square.nil? # Place in center
  square = empty_squares(brd).sample if square.nil? # Place in random

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd)
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def find_threatened_lines(brd)
  WINNING_LINES.select do |line|
    brd.values_at(*line).count(PLAYER_MARKER) == 2
  end
end

def find_check_mate(brd)
  WINNING_LINES.select do |line|
    brd.values_at(*line).count(COMPUTER_MARKER) == 2
  end
end

def who_starts
  loop do
    prompt "Who should go first? (1 => Player, 2 => Computer, 3 => Random)"
    answer = gets.chomp.to_i
    case answer
    when 1 then return 1
    when 2 then return 2
    when 3 then return [1, 2].sample
    end
    prompt "Invalid input."
  end
end

def alternate_player(current_player)
  return 1 if current_player == 2
  2 if current_player == 1
end

def place_piece!(brd, current_player)
  player_places_piece!(brd) if current_player == 1
  computer_places_piece!(brd) if current_player == 2
end


loop do
  prompt 'Welcome to Tic-Tac-Toe! The first player to 5 games wins!'
  prompt 'Press Enter to start.'
  gets.chomp

  player_score = 0
  computer_score = 0

  loop do
    board = initialize_board
    current_player = who_starts

    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)

    if someone_won?(board)
      winner = detect_winner(board)
      prompt "#{winner} won!"
      winner == 'Player' ? player_score += 1 : computer_score += 1
    else
      prompt "It's a tie!"
    end

    prompt "Player: #{player_score}, Computer: #{computer_score}"
    prompt 'Press Enter to continue.'
    gets.chomp

    if player_score >= 5
      prompt "Congratulations! You were the first to 5 games! You win!"
      break
    elsif computer_score >= 5
      prompt "Computer was the first to five games! Computer wins!"
      break
    end
  end

  prompt "Play again? (y or n)"
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt "Thanks for playing Tic Tac Toe! Good Bye!"
