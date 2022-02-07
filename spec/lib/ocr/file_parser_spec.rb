# frozen_string_literal: true

require 'ocr'

RSpec.describe Ocr::FileParser do
  let(:file_parser) { described_class.new('spec/fixtures/sample_file') }

  let(:parsed_accounts) do
    ['000000000', '111111111', '222222222', '333333333', '444444444', '555555555', '666666666', '777777777',
     '888888888', '999999999', '123456789', '000000051', '49006771?', '1234?678?', '111111111', '777777777',
     '200000000', '333333333', '888888888', '555555555', '666666666', '999999999', '490067715', '?23456789',
     '0?0000051', '49086771?']
  end

  describe '#process_file' do
    it 'returns the expected_results' do
      result = file_parser.process_file { |acct| acct }
      expect(result).to eq(parsed_accounts)
    end
  end
end
