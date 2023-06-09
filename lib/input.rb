# frozen_string_literal: true

module Input
  def messages(str)
    {
      'rows' => 'Enter maximum number of allowed guesses (typical is 12): ',
      'mode' => 'Please select a game mode (1: BREAK code, 2: SET code): ',
      'code' => "Create a code of four pegs, entering one color at a time (e.g. 'purple' 'blue' or 'b'): ",
      'guess' => "Enter your guess, choosing one color at a time (e.g. 'b' or 'blue'): ",
      'win' => 'Congratulations, you win!',
      'lose' => 'Sorry, you lose. Better luck next time!',
      'again' => 'Would you like to play again? (y/n?): ',
      'bye' => 'Thanks for playing! Goodbye.'
    }[str]
  end

  def get_int_between(message, min, max, allow_zero: true)
    loop do
      print message
      input = gets.chomp.to_i
      return input if (allow_zero && input.between?(min, max)) || input.between?(min, max - 1)

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
    puts "Available options are: #{valid_inputs.join(', ')}"
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
