# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require 'minitest/reporters'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative "../test/dummy/config/environment"
require "rails/test_help"


class ActiveSupport::TestCase

  # global; run once
  Rails.application.assets.processor.clobber
  Rails.application.assets.processor.process

end
