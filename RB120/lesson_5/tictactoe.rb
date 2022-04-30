module TextManipulation
  private

  def joinor(array, delimiter=', ', conjunctive='or')
    case array.size
    when 0 then ''
    when 1 then array.first.to_s
    when 2 then array.join(" #{conjunctive} ")
    else
      array[0..-2].join(delimiter) + "#{delimiter}#{conjunctive} #{array[-1]}"
    end
  end
end

module InputFromUser
  include TextManipulation

  private

  def ask_question_downcase(question, valid_answers, error_message=nil)
    answer = nil
    loop do
      puts question
      answer = gets.strip.downcase
      break if valid_answers.include?(answer)
      print_error_message(error_message, valid_answers)
    end
    answer
  end

  def ask_for_string_in_range(question, range, error_message=nil)
    answer = nil
    loop do
      puts question
      answer = gets.strip
      break if range.include?(answer.size)
      print_error_message(error_message, range)
    end
    answer
  end

  def ask_for_number_in_range(question, range, error_message=nil)
    answer = nil
    loop do
      puts question
      answer = gets.strip
      break if answer.to_i.to_s == answer && range.include?(answer.to_i)
      print_error_message(error_message, range)
    end
    answer.to_i
  end

  def print_error_message(error_message, validator)
    error_message ||= generate_generic_error(validator)
    puts error_message
  end

  def generate_generic_error(validator)
    if validator.class == Array
      "Must choose between (#{joinor(validator)})"
    else
      "Invalid input"
    end
  end

  def wait_for_input
    puts "Press enter to continue"
    gets
  end
end

class Board
  attr_reader :squares, :size, :winning_lines

  def initialize(size)
    @size = size
    @squares = {}
    establish_winning_lines
    reset
  end

  def [](num)
    @squares[num].marker
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    winning_lines.each do |line|
      squares_of_line = @squares.values_at(*line)

      if three_identical_markers?(squares_of_line)
        return squares_of_line.first.marker
      end
    end
    nil
  end

  def find_winning_move(marker)
    winning_lines.each do |line|
      squares_of_line = @squares.values_at(*line)
      square_at_risk = winning_square(squares_of_line, marker)
      at_risk_position = @squares.key(square_at_risk)
      return at_risk_position unless at_risk_position.nil?
    end
    nil
  end

  def reset
    (1..(size**2)).each { |key| @squares[key] = Square.new }
  end

  def draw
    draw_column_numbers
    size.times do |time|
      draw_border_type1
      draw_square_marker_line(time)
      draw_border_type1
      draw_border_type2 unless time == size - 1
    end
    puts
  end

  private

  attr_writer :winning_lines

  def establish_winning_lines
    self.winning_lines = []
    square_num_arr = (1..size**2).to_a
    rows_arr = rows(square_num_arr)

    self.winning_lines += winning_rows(square_num_arr)
    self.winning_lines += winning_columns(square_num_arr)
    self.winning_lines += winning_diagonals(rows_arr)
  end

  def winning_rows(square_num_arr)
    all_rows = rows(square_num_arr)
    sets_of_three(all_rows)
  end

  def winning_columns(square_num_arr)
    all_columns = columns(square_num_arr)
    sets_of_three(all_columns)
  end

  def sets_of_three(lines)
    sets = []
    lines.each do |arr|
      arr[0..-3].each_with_index do |_, index|
        sets << arr[index..(index + 2)]
      end
    end
    sets
  end

  def rows(square_num_arr)
    rows = []
    row = []
    square_num_arr.each do |num|
      row << num
      if row.size == size
        rows << row
        row = []
      end
    end
    rows
  end

  def columns(square_num_arr)
    rows(square_num_arr).transpose
  end

  def winning_diagonals(rows_arr)
    diag_arr1 = rtop_to_lbottom_diags(rows_arr)
    diag_arr2 = ltop_to_rbottom_diags(rows_arr, diag_arr1)

    diag_arr1 + diag_arr2
  end

  def rtop_to_lbottom_diags(rows_arr)
    diag_arr = []
    rows_arr.each do |row|
      row.each do |number|
        sub_arr = diag_from_top_right(number, row.first)
        diag_arr << sub_arr if sub_arr.size == 3
      end
    end
    diag_arr
  end

  def diag_from_top_right(column, left_most)
    row = 0
    sub_arr = []

    loop do
      number = (size * row) + column
      sub_arr << number unless number > size**2

      row += 1
      column -= 1
      break if column < left_most || sub_arr.size == 3
    end
    sub_arr
  end

  def ltop_to_rbottom_diags(rows_arr, diags)
    reversed_rows = rows_arr.map(&:reverse).flatten
    diags.map do |diag|
      diag.map { |number| reversed_rows[number - 1] }
    end
  end

  def draw_column_numbers
    number_line = '     '
    size.times { |time| number_line << "  #{time + 1}   " }
    puts number_line
    puts
  end

  def draw_border_type1
    puts '     ' + ("     |" * size).chop
  end

  def draw_border_type2
    puts '     ' + ("-----+" * size).chop
  end

  def draw_square_marker_line(row_num)
    line = ''
    1.upto(size) do |column|
      segment = ("  #{@squares[((size * row_num) + column)]}  |")
      line << segment
    end
    puts "  #{('a'.ord + row_num).chr}  " + line.chop
  end

  def three_identical_markers?(squares_of_line)
    markers = squares_of_line.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end

  def winning_square(squares_of_line, marker)
    if squares_of_line.count { |square| square.marker == marker } == 2
      squares_of_line.each do |square|
        return square if square.marker == Square::INITIAL_MARKER
      end
    end
    nil
  end
end

class SimulationBoard < Board
  def initialize(size, imported_winning_lines)
    @size = size
    @squares = {}
    import_winning_lines(imported_winning_lines)
    reset
  end

  private

  def import_winning_lines(imported_winning_lines)
    self.winning_lines = imported_winning_lines
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker.to_s
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_accessor :score, :name, :marker

  def initialize(name, marker)
    @name = name
    @marker = marker
    @score = 0
  end
end

class ScoreBoard
  def initialize(players)
    @players = players
    @num_of_players = players.size
  end

  def draw
    draw_border1
    draw_title_line
    draw_border2
    draw_names_line
    draw_border2
    draw_body_line
    draw_border2
  end

  private

  attr_reader :players, :num_of_players

  def draw_border1
    puts '+' + ('-' * (15 * num_of_players - 1)) + '+'
  end

  def draw_border2
    puts '+' + ((('-' * 14) + '+') * num_of_players)
  end

  def draw_title_line
    puts '|' + "Score".center((num_of_players * 15) - 1) + '|'
  end

  def draw_names_line
    puts '|' + players.map { |player| player.name.center(14) + '|' }.join
  end

  def draw_body_line
    puts '|' + players.map { |player| player.score.to_s.center(14) + '|' }.join
  end
end

class TTTSimulation
  INFINITY = Float::INFINITY

  def initialize(board, players)
    @starting_board = copy_board(board)
    @starting_players = players
    @current_player = players.first
    @depth_limit = determine_depth_limit
    @routes = Hash.new(0)
  end

  def best_route(board=starting_board, depth=1, players=@starting_players)
    pgs_value = pgs_rating(board, depth)
    return pgs_value if pgs_value

    children = child_node_ratings(board, players, depth)
    best_of_child_nodes(children, players, depth)
  end

  private

  attr_reader :starting_board, :starting_players, :current_player, :routes,
              :depth_limit

  def copy_board(board)
    sim_board = SimulationBoard.new(board.size, board.winning_lines)
    board.squares.each do |index, square_obj|
      sim_board[index] = square_obj.marker
    end
    sim_board
  end

  def determine_depth_limit
    case starting_board.size
    when 3    then 8
    when 4    then 6
    when 5, 6 then 4
    when 7..9 then 3
    end
  end

  def pgs_rating(board, depth)
    winner = board.winning_marker

    if winner == current_player
      INFINITY
    elsif starting_players.include?(winner)
      -INFINITY
    elsif board.full? || depth == depth_limit
      0
    end
  end

  def child_node_ratings(board, players, depth)
    children = {}
    children = reactive_sim(board, players, depth, children)

    if children.empty?
      children = non_reactive_sim(board, players, depth, children)
    end

    children
  end

  def reactive_sim(board, players, depth, children)
    move = square_at_risk(board, players)
    children[move] = next_simulation(board, move, players, depth) if move
    children
  end

  def non_reactive_sim(board, players, depth, children)
    board.unmarked_keys.shuffle.each do |sqr|
      children[sqr] = next_simulation(board, sqr, players, depth)
      break if children.include?(INFINITY)
    end
    children
  end

  def best_of_child_nodes(children, players, depth)
    if depth == 1
      best_sqrs = children.select do |_, value|
        value == children.values.max
      end

      best_sqrs.keys.sample
    elsif current_player == players.first
      children.values.max
    else
      children.values.min
    end
  end

  def next_simulation(board, move, players, depth)
    depth += 1
    sim_board = simulate_move(board, move, players.first)
    best_route(sim_board, depth, players.rotate)
  end

  def square_at_risk(board, players)
    move = nil

    players.each do |marker|
      move = board.find_winning_move(marker) if move.nil?
    end

    move
  end

  def simulate_move(board_obj, empty_square, marker)
    sim_board = copy_board(board_obj)
    sim_board[empty_square] = marker
    sim_board
  end
end

class TTTGame
  include TextManipulation, InputFromUser

  INFINITY = Float::INFINITY

  def initialize
    @players = []
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  attr_accessor :first_to_move
  attr_reader :board, :score_board, :human, :computer, :players,
              :player_markers

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_boards
    score_board.draw
    puts
    show_turn_order
    puts
    board.draw
    puts
  end

  def clear_screen_and_display_boards
    clear
    display_boards
  end

  def clear
    system "clear"
  end

  def display_result
    clear_screen_and_display_boards

    if winning_player.nil?
      puts "It's a tie!"
    else
      puts "#{winning_player.name} won!"
    end
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def main_game
    loop do
      ready_new_game
      player_move
      award_points
      display_result
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def ready_new_game
    set_human_name_and_marker if players.empty?
    clear
    establish_board_size
    establish_player_order_and_markers
    update_scoreboard
    clear_screen_and_display_boards
  end

  def establish_board_size
    error_msg = "Sorry, must be a number between 3 and 9."

    size = ask_for_number_in_range(board_size_question, (3..9), error_msg)
    @board = Board.new(size)
  end

  def board_size_question
    <<-QUESTION
What size board would you like to use?(min: 3, max: 9)
The number you enter will be both the height and width of the board.

    QUESTION
  end

  def establish_player_order_and_markers
    establish_num_of_players if players.size == 1
    establish_player_order
  end

  def set_human_name_and_marker
    human_name = new_human_name
    human_marker = new_custom_marker

    human = Player.new(human_name, human_marker)
    players << human
  end

  def establish_num_of_players
    question = "How many computer opponents do you want to face? (max: 5)"
    error_msg = "Please choose a number between 1 and 5."

    num_of_opponents = ask_for_number_in_range(question, (1..5), error_msg)
    icons = [:O, :△, :□, :◇, :+].shuffle
    names = ['Hal', 'Roy', 'Ava', 'Ash', 'Eve'].shuffle

    num_of_opponents.times do |index|
      players << Player.new(names[index], icons[index])
    end

    resolve_conflicting_names_or_markers
  end

  def resolve_conflicting_names_or_markers
    players.each_with_index do |player, index|
      next if index.zero?

      player.name = 'Max' if player.name == players[0].name
      player.marker = :X if player.marker == players[0].marker
    end
  end

  def establish_player_order
    @player_markers = players.map(&:marker).shuffle

    self.first_to_move = if go_first?
                           players[0].marker
                         else
                           players[1..-1].sample.marker
                         end

    @player_markers.rotate! until current_marker == first_to_move
  end

  def go_first?
    question = "Would you like to go first? (yes/no/random)"
    valid_answers = %w(y yes n no r random)
    error_message = "Sorry, must choose between yes, no, or random"

    answer = ask_question_downcase(question, valid_answers, error_message)
    answer = answer.chr

    answer = ['y', 'n'].sample if answer == 'r'
    answer == 'y'
  end

  def new_human_name
    question = "What is your name? (Max: 8 characters)"
    error_msg = "Name must be between 1 and 8 characters long."

    ask_for_string_in_range(question, (1..8), error_msg)
  end

  def new_computer_name
    ['Hal', 'Roy', 'Ava', 'Ash', 'Eve'].sample
  end

  def new_custom_marker
    question = "What marker would you like to use? (Must be 1 character)"
    error_message = "Marker must be a single character"

    answer = nil
    loop do
      answer = ask_for_string_in_range(question, (1..1), error_message)
      break unless answer == Square::INITIAL_MARKER
      puts "Sorry, that's our initial marker! " \
           "Please choose a different marker."
    end
    answer.to_sym
  end

  def show_turn_order
    puts turn_order_border1
    puts turn_order_title_line
    puts turn_order_border2
    puts turn_order_header_line
    puts turn_order_border3
    puts turn_order_body_line
    puts turn_order_border3
  end

  def turn_order_border1
    '+' + ('-' * (15 * players.size - 1)) + '+'
  end

  def turn_order_border2
    '+' + ((('-' * 14) + '+') * players.size)
  end

  def turn_order_border3
    '+' + ((('-' * 10) + '+' + ('-' * 3) + '+') * players.size)
  end

  def turn_order_title_line
    '|' + "Turn Order".center((players.size * 15) - 1) + '|'
  end

  def turn_order_header_line
    line = '|'
    players.size.times do |time|
      text = case time
             when 0           then 'Current Turn'
             when 1           then 'Next Turn'
             when 2..INFINITY then "#{time} Turns"
             end
      line << (text.center(14) + '|')
    end
    line
  end

  def turn_order_body_line
    line = '|'
    player_markers.each do |marker|
      name = whos_marker(marker)

      text = name.center(10) + '|' + marker.to_s.center(3) + '|'
      line << text
    end
    line
  end

  def update_scoreboard
    @score_board = ScoreBoard.new(players)
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_boards
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
    else
      computer_moves
    end
    @player_markers.rotate!
  end

  def human_turn?
    current_marker == players.first.marker
  end

  def current_marker
    player_markers.first
  end

  def human_moves
    open_coords = board.unmarked_keys.map { |square| square_to_coords(square) }

    puts "Choose a square (#{joinor(open_coords)}): "
    square = nil
    loop do
      square = gets.chomp.downcase
      break if open_coords.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    square = coords_to_square(square)
    board[square] = current_marker
  end

  def square_to_coords(square_num)
    square_num -= 1

    y_coord = square_num / board.size
    x_coord = (square_num % board.size) + 1

    y_coord = ('a'.ord + y_coord).chr
    y_coord + x_coord.to_s
  end

  def coords_to_square(coordinates)
    y_coord = coordinates.chr.ord - 'a'.ord
    x_coord = coordinates[1..-1].to_i

    (board.size * y_coord) + x_coord
  end

  def computer_moves
    sim = TTTSimulation.new(board, @player_markers)
    move = sim.best_route
    board[move] = player_markers.first

    clear_screen_and_display_boards

    puts "#{whos_marker(current_marker)} placed their marker at " \
         "#{square_to_coords(move)}"
    wait_for_input
  end

  def whos_marker(marker)
    players.select { |player| player.marker == marker }.first.name
  end

  def award_points
    winner = winning_player
    winner.score += 1 if winner
  end

  def winning_player
    players.select { |player| player.marker == board.winning_marker }.first
  end

  def play_again?
    question = "Would you like to play again? (y/n)"
    valid_answers = %w(y yes n no)
    error_message = "Sorry, must choose yes or no"

    answer = ask_question_downcase(question, valid_answers, error_message)
    answer = answer.chr

    answer == 'y'
  end

  def reset
    board.reset
  end
end

game = TTTGame.new
game.play
