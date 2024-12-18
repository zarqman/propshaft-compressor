require "test_helper"

class Propshaft::CompressorTest < ActiveSupport::TestCase

  test "compile assets" do
    processor = Rails.application.assets.processor

    files = Dir["#{processor.output_path}/*"]
    assert_operator files.count, :>=, 1

    Propshaft::Compressor.compress_assets processor

    Propshaft::Compressor::FORMATS.each_key do |ext|
      files.each do |fn|
        assert File.exist?("#{fn}#{ext}"), "Missing compiled asset: #{fn}#{ext}"
      end
    end
  end

end
