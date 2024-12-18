module Propshaft
  module Compressor
    class Railtie < ::Rails::Railtie

      rake_tasks do
        load 'propshaft/compressor/assets.rake'
      end

    end
  end
end
