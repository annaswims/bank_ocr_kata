# frozen_string_literal: true

require 'ocr'

RSpec.describe Ocr::Account do
  let(:valid_acct) { '457508000' }
  let(:invalid_char_acct) { '86110??36' }
  let(:invalid_checksum_acct) { '664371495' }

  describe '#invalid_text' do
    it 'acceps valid accounts' do
      account = described_class.new(valid_acct)
      expect(account.invalid_text).to eq(nil)
    end

    it 'flags illegible accounts' do
      account = described_class.new(invalid_char_acct)

      expect(account.invalid_text).to eq(Ocr::Account::ILLEGIBLE_DIGIT_TEXT)
    end

    it 'flags invalid checksum accounts' do
      account = described_class.new(invalid_checksum_acct)

      expect(account.invalid_text).to eq(Ocr::Account::INVALID_CHECKSUM_TEXT)
    end
  end
end
