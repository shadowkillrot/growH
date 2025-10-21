require 'cucumber/rails'
require 'capybara/cucumber'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile"
end

Cucumber::Rails::Database.javascript_strategy = :truncation