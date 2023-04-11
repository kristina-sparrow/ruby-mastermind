# frozen_string_literal: true

require_relative 'instructions'
require_relative 'input'
require_relative 'display'

class Game
  attr_reader :rows, :code, :gameboard, :game_mode, :breaker, :maker
  attr_accessor :turn

  include Instructions
  include Input
  include Display

  def initialize
    clear_screen
    puts start_screen
  end

  def play
    playing = true
    while playing
      new_game
      playing = play_again?
    end
    puts messages('bye')
  end

  private

  def new_game
    setup_game
    @gameboard = Gameboard.new(code: code, rows: rows)
    play_turn until game_over?
    end_game
  end

  def setup_game
    self.turn = -1
    @game_mode = get_game_mode
    @rows = get_rows
    @breaker = game_mode == 1 ? Human.new : Computer.new
    @maker = game_mode == 1 ? Computer.new : Human.new
    @code = maker.set_code
    clear_screen
  end

  def get_game_mode
    get_int_between(messages('mode'), 1, 2) # 1 = human breaker, 2 = human maker
  end

  def get_rows
    get_int_between(messages('rows'), 1, 15)
  end

  def play_turn
    self.turn += 1
    clear_screen
    4.times do |i|
      puts gameboard
      puts 'Thinking... this may take awhile' if breaker.name == 'Computer'
      guess = breaker.new_guess(gameboard)
      gameboard.add_guess(row: turn, col: i, guess: guess)
      clear_screen
    end
    gameboard.update_keys(row: turn)
    puts gameboard
  end

  def game_over?
    return 'loser' if rows == turn + 1 && gameboard.keys_at(turn).uniq != ['red']
    return 'winner' if gameboard.keys_at(turn).uniq == ['red']

    false
  end

  def end_game
    clear_stdin
    breaker.breaker_end_game(game_over?)
    puts 'Code:'
    code_board = Gameboard.new(rows: 1, board: Gameboard.create_row(guess: code))
    puts code_board
  end

  def play_again?
    get_yes_no(messages('again')) == 'y'
  end

  def clear_stdin
    $stdin.getc while $stdin.ready?
  end
end
