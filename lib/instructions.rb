# frozen_string_literal: true

module Instructions
  def start_screen
    <<~HEREDOC
      #{'Welcome to Mastermind!'.bold.underline.italic}

      Mastermind is a code-breaking game between two players:
        - The code #{'BREAKER'.red.bold}
        - The code #{'SETTER'.red.bold}

      The code #{'SETTER'.red.bold} sets the code, which is a sequence of four#{' '}
      colors, chosen from the following:
        - #{'Red'.bold.red}, #{'Blue'.bold.blue}, #{'Green'.bold.green}, #{'Yellow'.bold.yellow}, #{'Cyan'.bold.cyan}, #{'Purple'.bold.purple}

      The code #{'BREAKER'.red.bold} attempts to guess the code in the number of turns#{' '}
      specified when starting a game. After each guess, four #{'keys'.bold} will be updated#{' '}
      to provide hints. A #{'white'.bold.white} key indicates the guess contains a correct
      color in the wrong position, while a #{'red'.bold.red} means a correct color AND position.

      #{'NOTE'.bold} that these keys appear in #{'no particular order'.bold}, so the breaker won't#{' '}
      explicitly know WHICH colors have been guessed correctly via the keys alone.

      Below is a sample game:

      #{'Code:'.bold.underline}
      #{Gameboard.new(rows: 1, board: [{ guess: %w[red purple purple blue], # {' '}
                                         keys: %w[empty empty empty empty] }])}

      #{'Gameplay:'.bold.underline}
      #{Gameboard.new(rows: 5, board: [{ guess: %w[red red blue blue], # {' '}
                                         keys: %w[used red used red] }, # {' '}
                                       { guess: %w[red red green green],  # {' '}
                                         keys: %w[used red used used] },  # {' '}
                                       { guess: %w[red yellow blue yellow], # {' '}
                                         keys: %w[red used white used] }, # {' '}
                                       { guess: %w[red purple purple blue], # {' '}
                                         keys: %w[red red red red] }, # {' '}
                                       { guess: %w[empty empty empty empty],  # {' '}
                                         keys: %w[empty empty empty empty] }])}

      This program has two game modes:
        - 1: Play as the code #{'BREAKER'.red.bold}, and try to guess a randomly generated code.
        - 2: Play as the code #{'SETTER'.red.bold}, and try to fool the computer's algorithm!
             (Note, the algorithm will likely win in 5 turns on average)
      #{'       '}
    HEREDOC
  end
end
