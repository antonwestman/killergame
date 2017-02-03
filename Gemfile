source 'https://rubygems.org'
ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.0'

gem 'active_model_serializers'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'devise'
gem 'devise_token_auth'
gem 'omniauth'
gem 'pundit'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'ransack', github: 'activerecord-hackery/ransack'
gem 'will_paginate', github: 'jonatack/will_paginate'

gem 'awesome_print'

gem 'simplecov', require: false, group: :test

#   https://github.com/brettjnorris/workflow/commit/b95d882cb0b82266ca2c4439b9df1bb63b6bef6c
gem 'workflow', git: 'https://github.com/antonwestman/workflow.git'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'faker'
  gem 'dotenv-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'codeclimate-test-reporter', require: nil
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'rubocop', require: false
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
