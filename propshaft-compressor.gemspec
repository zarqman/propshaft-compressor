require_relative 'lib/propshaft/compressor/version'

Gem::Specification.new do |spec|
  spec.name        = 'propshaft-compressor'
  spec.version     = Propshaft::Compressor::VERSION
  spec.authors     = [ 'thomas morgan' ]
  spec.email       = [ 'tm@iprog.com' ]
  spec.homepage    = 'https://github.com/zarqman/propshaft-compressor'
  spec.summary     = 'Extends Propshaft to add asset compression using gzip, brotli, zstandard'
  spec.description = 'Adds asset compression to Propshaft. Compresses with gzip, brotli, and/or zstandard.'
  spec.license     = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'LICENSE.txt', 'Rakefile', 'README.md']
  end

  spec.required_ruby_version = '>= 2.7'

  spec.add_dependency 'propshaft', '>= 1.1'
  spec.add_dependency 'railties', '>= 7'
end
