source "https://rubygems.org"

gem "rails", "3.2.9"

# Server
gem "thin"

# Data
gem "active_model_serializers"

# Assets
gem "sass-rails", "~> 3.2.3"
gem "coffee-rails", "~> 3.2.1"
gem "uglifier", ">= 1.0.3"

# Front end
gem "haml"
gem "jquery-rails"
gem "bootstrap-sass"
gem "rails-backbone"
gem "haml_coffee_assets"

# Third party services
gem "octokit"
gem "omniauth-twitter"
gem "klout"

group :production do
  gem "pg"
end

group :development, :test do
  gem "sqlite3"
  gem "konacha"
  gem "poltergeist"
end

group :development do
  gem "foreman"
end

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "factory_girl_rails"
  gem "simplecov", require: false
end
