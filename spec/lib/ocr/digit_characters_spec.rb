# frozen_string_literal: true

require 'ocr'

RSpec.describe Ocr::DigitCharacters do
  let(:illegible_eight) do
    ' _ '\
      '|_|'\
      ' _|'
  end

  describe '#fuzzy_matches_digits' do
    it 'returns similar numbers' do
      matches = described_class.fuzzy_matches_digits(illegible_eight)
      expect(matches).to eq([3, 5, 8, 9])
    end
  end
end
