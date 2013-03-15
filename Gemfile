source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'pg'

# See https://github.com/jsmestad/pivotal-tracker/pull/71
# gem 'pivotal-tracker', '~> 0.5.10'
gem 'pivotal-tracker', git: "https://github.com/amair/pivotal-tracker.git", branch: "master"

# Bug in ActiveAdmin: https://github.com/gregbell/active_admin/issues/1773
# gem 'activeadmin'
gem 'activeadmin', github: 'Daxter/active_admin', branch: 'bugfix/1773-execjs'
gem 'meta_search', '>= 1.1.0.pre'

gem 'jquery-rails'
gem 'haml'
gem 'jbuilder'
gem 'draper'

gem 'newrelic_rpm'

gem 'bcrypt-ruby'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'

  gem 'bourbon'
  gem 'neat'
  gem 'rocks'

  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
end

group :development do
  gem 'haml-rails'
end

group :test, :development do
  gem 'cucumber-rails',   require: false
  gem 'rspec-rails'
  gem "json_spec"

  gem "factory_girl_rails", "~> 4.2.1"
  gem 'capybara-webkit'
  gem 'database_cleaner'
  gem 'launchy'

  gem 'spring'
end

group :test do
  gem 'webmock'
  gem 'shoulda'
end
