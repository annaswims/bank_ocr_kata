# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/ocr/*.rb"].each do |rbfile|
  require rbfile
end
