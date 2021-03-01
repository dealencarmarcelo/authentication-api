source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'rails', '~> 6.0.3', '>= 6.0.3.5'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'

gem 'bcrypt', '~> 3.1.7'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'rack-cors'

group :development, :test do
  gem 'rspec-rails', '~> 4.0.2'  
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
