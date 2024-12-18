namespace :assets do
  Rake::Task['assets:precompile'].enhance do
    Rake::Task['assets:compress'].invoke
  end

  task :compress do
    Propshaft::Compressor.compress_assets Rails.application.assets.processor
  end
end
