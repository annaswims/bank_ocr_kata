# frozen_string_literal: true

module Ocr
  class DigitCharacters
    ILLEGIBLE_DIGIT = '?'
    STR_TO_DIGITS = { ' _ '\
                      '| |'\
                      '|_|' => 0,
                      '   '\
                      '  |'\
                      '  |' => 1,
                      ' _ '\
                      ' _|'\
                      '|_ ' => 2,
                      ' _ '\
                      ' _|'\
                      ' _|' => 3,
                      '   '\
                      '|_|'\
                      '  |' => 4,
                      ' _ '\
                      '|_ '\
                      ' _|' => 5,
                      ' _ '\
                      '|_ '\
                      '|_|' => 6,
                      ' _ '\
                      '  |'\
                      '  |' => 7,
                      ' _ '\
                      '|_|'\
                      '|_|' => 8,
                      ' _ '\
                      '|_|'\
                      ' _|' => 9 }.freeze

    def self.characters_to_digit(str)
      STR_TO_DIGITS[str] || ILLEGIBLE_DIGIT
    end
  end
end
