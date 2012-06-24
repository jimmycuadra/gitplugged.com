source "https://rubygems.org"

gem "rails", "3.2.6"

# Server
gem "thin"

# Assets
gem "sass-rails"
gem "coffee-rails"
gem "uglifier"

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
  gem "pry-rails"
  gem "pry-nav"
  gem "pry-coolline"
  gem "jasminerice"
end

group :development do
  gem "foreman"
end

group :test do
  gem "rspec-rails"
  gem "capybara"
  gem "capybara-webkit"
  gem "simplecov", require: false
end
