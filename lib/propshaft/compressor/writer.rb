require 'zlib'
begin
  require 'brotli'
rescue LoadError
end
begin
  require 'zstd-ruby'
rescue LoadError
end

module Propshaft
  module Compressor

    FORMATS = {}  # { '.ext' => [GzipWriter, 9] }

    class Writer
      def self.compress(...)
        new(...).compress
      end

      def initialize(from:, to:, level: 8)
        @from  = from
        @to    = to
        @level = level
      end

      def compress
        File.open(@from, 'rb') do |from_io|
          File.open(@to, 'wb+') do |to_io|
            writer = build_writer to_io, from_io.mtime
            from_io.each do |blk|
              writer.write blk
            end
          ensure
            writer&.close
          end
          File.utime from_io.atime, from_io.mtime, @to
        end
      end

      def build_writer(io)
        raise 'abstract'
      end
    end

    if defined? Brotli::Writer
      class BrotliWriter < Writer
        def build_writer(io, _)
          Brotli::Writer.new io, quality: @level
        end
      end
      FORMATS['.br'] = [ BrotliWriter, 11 ]
    end

    class GzipWriter < Writer
      def build_writer(io, mtime)
        Zlib::GzipWriter.new(io, @level).tap do |gz|
          gz.mtime = mtime
        end
      end
    end
    FORMATS['.gz'] = [ GzipWriter, 9 ]

    if defined? Zstd::StreamWriter
      class ZstdWriter < Writer
        def build_writer(io, _)
          Zstd::StreamWriter.new io, level: @level
        end
      end
      FORMATS['.zst'] = [ ZstdWriter, 22 ]

      if Zstd::VERSION <= '1.5.6.6'
        module ZstdStreamWriterPatch
          # monkeypatch to silence deprecation warning
          def initialize(io, level: nil)
            @io = io
            @stream = Zstd::StreamingCompress.new level: level
          end
        end
        Zstd::StreamWriter.prepend ZstdStreamWriterPatch
      end
    end

  end
end

