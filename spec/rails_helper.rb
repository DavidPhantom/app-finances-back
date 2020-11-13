ENV['RAILS_ENV'] ||= 'test'

if ENV['RAILS_ENV'] == 'test' || ENV['RAILS_ENV'] == 'ci'
  require 'simplecov'

  SimpleCov.profiles.define 'coverage' do
    load_profile 'rails'

    add_filter '/vendor/'
  end

  if ENV['CIRCLE_ARTIFACTS']
    dir = File.join(ENV['CIRCLE_ARTIFACTS'], 'coverage')
    SimpleCov.coverage_dir(dir)
  end

  SimpleCov.start 'coverage'
  puts 'required simplecov'
end

require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

RSpec.configure do |config|
  config.include Request::AuthHelpers
  config.infer_base_class_for_anonymous_controllers = true
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false
  config.profile_examples = 3

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.example_status_persistence_file_path = 'tmp/rspec_examples.txt'
  config.order = :random

  config.before(:suite) do
    Rails.application.load_seed
  end
end

ActiveRecord::Migration.maintain_test_schema!
