# frozen_string_literal: true

module Ocr
  class FileParser
    def initialize(file_name)
      @file_data = File.read(file_name).split("\n")
      @file_entry_count = @file_data.size / 4
    end

    def process_file
      (0..@file_entry_count).collect do |account_count|
        account_number = entry_to_digits(account_count)
        yield(account_number)
      end
    end

    def entry_to_digits(account_count)
      acct_str = account_entry_str(account_count)
      # Each account entry has 9
      (0..(Ocr::Account::LENGTH - 1)).collect do |position|
        digit_string = digit_string_for_position(acct_str, position)
        DigitCharacters.characters_to_digit(digit_string)
      end.join
    end

    # returns array of strings that make up the account number from the file
    #
    # for example:
    #
    #   ["    _  _  _  _  _  _     _ ",
    #    "|_||_|| ||_||_   |  |  | _ ",
    #    "  | _||_||_||_|  |  |  | _|"]

    def account_entry_str(account_count)
      line_num = account_count * 4
      @file_data[line_num, 3]
    end

    # each account entry is made up of a series 3x3 matrix of pipes and underscores.
    # This will return a single digit string with no line breaks
    #
    # for example:
    #
    # '_ | ||_|'
    #
    # a.k.a
    #
    # ' _ '\
    # '| |'\
    # '|_|'

    def digit_string_for_position(digits_string_arr, position)
      ind = position * 3 # three characters per digit
      (0..2).collect { |row| digits_string_arr[row][ind, 3] }.join
    end
  end
end
