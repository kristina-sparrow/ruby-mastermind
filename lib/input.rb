# frozen_string_literal: true

module Input
  def messages(str)
    {
      'rows' => 'Enter number of maximum guesses (typical is 12): ',
      'mode' => 'Please select a game mode (1: BREAK code, 2: SET code): ',
      'code' => "Enter a valid code (e.g. 'p g r r' or 'purple green red red'): ",
      'guess' => "Enter a valid guess (e.g. 'b' or 'blue'): ",
      'win' => 'Congratulations, you win!',
      'lose' => 'Sorry, you lose. Better luck next time!',
      'again' => 'Would you like to play again? (y/n?): ',
      'bye' => 'Thanks for playing! Goodbye.'
    }[str]
  end

  def get_int_between(message, min, max, zero: true)
    loop do
      print message
      int = gets.chomp.to_i
      if int.zero? && !zero
        int = min - 1
      elsif (min..max).include?(int)
        return int
      end
      puts "Number must be between #{min} & #{max}, inclusive."
      puts "Zero #{'not ' unless zero}included." if (min..max).include?(0)
    end
  end

  def get_yes_no(message)
    print message
    ans = gets.chomp[0]
    until %w[y n Y N].include?(ans)
      puts "Please enter 'y' or 'n'."
      print message
      ans = gets.chomp[0]
    end
    ans.downcase
  end

  def get_valid_input(message, valid_inputs)
    print message
    input = gets.chomp.split(' ')[0].downcase
    until valid_inputs.include?(input)
      puts 'Input should be a valid color or letter.'
      puts "E.g. 'blue', 'yellow', or 'y'."
      puts "Available options are: #{valid_inputs.join(', ')}"
      print message
      input = gets.chomp.split(' ')[0].downcase
    end
    input
  end

  def get_code(message)
    valid_inputs = %w[r g b y p c]
    code = Array.new(4) { get_valid_input(message, valid_inputs) }
    code.map { |str| color(str) }
  end

  def get_guess(message)
    valid_inputs = %w[r g b y p c]
    guess = get_valid_input(message, valid_inputs)
    color(guess)
  end

  def color(color)
    {
      'r' => 'red',
      'b' => 'blue',
      'g' => 'green',
      'p' => 'purple',
      'c' => 'cyan',
      'y' => 'yellow'
    }[color]
  end
end
