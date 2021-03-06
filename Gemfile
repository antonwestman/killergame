source 'https://rubygems.org'
ruby '2.4.1'

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
gem 'rolify'

# User paranoia for soft deletes
gem 'paranoia', '~> 2.2'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

gem 'ransack', git: 'https://github.com/activerecord-hackery/ransack.git'
gem 'will_paginate', git: 'https://github.com/jonatack/will_paginate.git'

gem 'awesome_print'

#   https://github.com/brettjnorris/workflow/commit/b95d882cb0b82266ca2c4439b9df1bb63b6bef6c
gem 'workflow', git: 'https://github.com/antonwestman/workflow.git'

group :staging do
  gem 'recipient_interceptor'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :test do
  gem 'codeclimate-test-reporter', require: nil
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rubocop', '~> 0.49.0', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
