require_relative 'display.rb'

class Gameboard
  include Display

  attr_reader :rows, :secret_code, :board

  def initialize(secret_code: Array.new(4, 'red'), rows: 12, board: empty_board(rows))
    @rows = rows
    @secret_code = secret_code
    @board = board
  end

  def add_guess(row:, col:, guess:)
    board[row][:guess][col] = guess
  end

  def update_keys(row:)
    keys = []
    temp_guess = board[row][:guess]
    temp_code = secret_code.dup

    temp_guess.each_with_index do |str, i|
      if temp_code[i] == str
        keys.push('red')
        temp_code[i] = 'empty'
        temp_guess[i] = 'found'
      end
    end

    temp_guess.each do |str|
      case temp_code.index(str)
      when nil
        next
      else
        keys.push('white')
        temp_code[temp_code.index(str)] = 'empty'
      end
    end

    keys += Array.new(4 - keys.length, 'used') if keys.length != 4
    board[row][:keys] = keys.shuffle
  end

  def pegs_at(row)
    board[row][:guess]
  end

  def keys_at(row)
    board[row][:keys]
  end

  def to_s
    game_rows = board.map { |obj| game_row(obj[:guess], obj[:keys]) }.join("\n" + middle_row + "\n")
    top_row + "\n" + game_rows + "\n" + bottom_row
  end

  private

  def empty_board(rows)
    Array.new(rows) { create_row }
  end

  def create_row(guess: Array.new(4, 'empty'), keys: Array.new(4, 'empty'))
    { guess: guess, keys: keys }
  end
end
