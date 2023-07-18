source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

gem 'rails', '~> 7.0.6'
gem 'pg', '~> 1.5'
gem 'sass-rails', '~> 6.0'
gem 'webpacker', '~> 5.4'
gem 'turbolinks', '~> 5.2'
gem 'jbuilder', '~> 2.11'
gem 'bootsnap', '~> 1.16', require: false
gem 'friendly_id', '~> 5.5'
gem 'pry', '~> 0.14.2'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'awesome_print'
  gem 'web-console', '~> 4.2'
  gem 'listen', '~> 3.8'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1'
end

group :test do
  gem 'capybara', '~> 3.39'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
