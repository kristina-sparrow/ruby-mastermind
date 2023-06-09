# frozen_string_literal: true

module Display
  TOP_LEFT = "\u2554"
  TOP_RIGHT = "\u2557"
  BOTTOM_LEFT = "\u255a"
  BOTTOM_RIGHT = "\u255d"
  HOR = "\u2550"
  VER = "\u2551"
  T_DOWN = "\u2566"
  T_UP = "\u2569"
  T_RIGHT = "\u2560"
  T_LEFT = "\u2563"
  T_ALL = "\u256c"

  BOARD_WIDTH = 13
  KEY_WIDTH = 9

  def top_row
    TOP_LEFT + HOR * BOARD_WIDTH + T_DOWN + HOR * KEY_WIDTH + TOP_RIGHT
  end

  def middle_row
    T_RIGHT + HOR * BOARD_WIDTH + T_ALL + HOR * KEY_WIDTH + T_LEFT
  end

  def bottom_row
    BOTTOM_LEFT + HOR * BOARD_WIDTH + T_UP + HOR * KEY_WIDTH + BOTTOM_RIGHT
  end

  def game_row(pegs, keys)
    pegs = pegs.map { |str| get_peg(str) }
    keys = keys.map { |str| get_key(str) }
    "#{VER} #{pegs.join('  ')}  #{VER} #{keys.join(' ')} #{VER}"
  end

  def get_peg(color = 'empty')
    {
      'empty' => "\u25ef",
      'red' => "\u2b24".red,
      'green' => "\u2b24".green,
      'blue' => "\u2b24".blue,
      'yellow' => "\u2b24".yellow,
      'purple' => "\u2b24".purple,
      'cyan' => "\u2b24".cyan
    }[color]
  end

  def get_key(color = 'empty')
    {
      'empty' => "\u25cb",
      'used' => "\u25cc",
      'red' => "\u25cf".red,
      'white' => "\u25cf".white
    }[color]
  end

  def clear_screen
    system('clear') || system('cls')
  end
end
