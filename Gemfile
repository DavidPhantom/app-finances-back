source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'awesome_print'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'fast_jsonapi'
gem 'knock'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
gem 'rails-controller-testing', '0.0.3'
gem 'strong_migrations'

group :development, :test, :ci do
  gem 'brakeman'
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rubocop', require: false
end

group :development, :test do
  gem 'byebug'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'shog'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test, :ci do
  gem 'database_cleaner', '1.7.0'
  gem 'json_matchers', '~> 0.9.0'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers'
end

group :test do
  gem 'fuubar'
  gem 'simplecov', require: false
end
