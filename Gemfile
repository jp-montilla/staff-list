# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'mysql2', '~> 0.5.2'
gem 'puma', '~> 5.6'
gem 'rails', '~> 5.1.7'
gem 'sass-rails', '~> 5.0'
gem 'sqlite3'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'

gem 'administrate', '~> 0.11.0'
gem 'better_errors', '~> 2.5', '>= 2.5.1'
gem 'chartkick'
gem 'devise', '~> 4.7', '>= 4.7.1'
gem 'devise-security'
gem 'hirb', '~> 0.7.3'
gem 'kaminari'

gem 'administrate-field-carrierwave', '~> 0.5.0'
gem 'administrate-field-hidden', '~> 0.0.3'
gem 'bootstrap', '~> 4.3', '>= 4.3.1'
gem 'carrierwave', '~> 2.0', '>= 2.0.1'
gem 'file_validators'
gem 'jquery-rails'
gem 'pry', '~> 0.12.2'
gem 'pundit'
gem 'ransack'
gem 'remotipart', '~> 1.4', '>= 1.4.3'
gem 'webpacker', '~> 3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '>= 2.15'
  gem 'factory_bot_rails'
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
