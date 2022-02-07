# frozen_string_literal: true

module Ocr
  class Account
    INVALID_CHECKSUM_TEXT = 'ERR'
    ILLEGIBLE_DIGIT_TEXT = 'ILL'
    LENGTH = 9

    def initialize(number)
      @number = number
    end

    def invalid_text
      return ILLEGIBLE_DIGIT_TEXT unless contains_legible_digits?
      return INVALID_CHECKSUM_TEXT unless checksum_is_correct?

      nil
    end

    private

    def contains_legible_digits?
      !@number.include?(Ocr::DigitCharacters::ILLEGIBLE_DIGIT)
    end

    def checksum_is_correct?
      ((1..9).collect { |i| @number[9 - i].to_i * i }.reduce(:+) % 11).zero?
    end
  end
end
