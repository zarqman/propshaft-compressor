require 'propshaft'

%w(
  version
  writer
  railtie
).each do |f|
  require_relative "compressor/#{f}"
end


module Propshaft
  module Compressor

    SKIP_EXTS = %w(jpg mp3 mp4 png webp woff woff2)

    def self.compress_assets(processor)
      processor.load_path.assets.each do |asset|
        in_path = processor.output_path.join(asset.digested_path).to_s
        next if SKIP_EXTS.any?{|ext| in_path.ends_with? ".#{ext}" }

        FORMATS.each do |ext, (klass, level)|
          out_path = processor.output_path.join(asset.digested_path.to_s+ext)
          unless out_path.exist?
            Propshaft.logger.info "Writing #{asset.digested_path}#{ext}"
            klass.compress from: in_path, to: out_path, level: level
          end
        end
      end
    end

  end
end
