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

    DIGITS_TO_STR = Ocr::DigitCharacters::STR_TO_DIGITS.invert

    def self.characters_to_digit(str)
      STR_TO_DIGITS[str] || ILLEGIBLE_DIGIT
    end

    def self.fuzzy_matches_digits(str)
      (0..9).select do |n|
        DidYouMean::Levenshtein.distance(DIGITS_TO_STR[n], str) <= 1
      end
    end
  end
end
