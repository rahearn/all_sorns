source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'

# We need to use rails 6-1.stable to get around a problem with good_job:
# https://github.com/bensheldon/good_job/issues/1016#issuecomment-1644915406
gem 'rails', github: "rails/rails", branch: '6-1-stable'
# gem 'rails', '~> 6.1.4', '>= 6.1.4.6'
gem 'good_job', '>= 1.13.2'
gem 'pg'
gem 'httparty'
gem 'federal_register', '~> 0.7.6'
gem 'rexml'
gem 'saxerator'
gem 'pg_search'
gem 'kaminari', '>= 1.2.1'
gem 'scenic', '>= 1.5.5'

# Use Puma as the app server
gem 'puma', '~> 5.6'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6.0.0'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.4', '>= 5.4.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.11', '>= 2.11.5'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.1.2'

  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'factory_bot_rails', '>= 6.2.0'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.2.0'
  gem 'listen', '~> 3.7'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.35.3'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers', '>= 4.6.0'
  gem 'launchy'
end
