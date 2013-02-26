source 'https://rubygems.org'

gem 'rails', '3.2.12'

gem 'pg'

# Bug in ActiveAdmin: https://github.com/gregbell/active_admin/issues/1773
# gem 'activeadmin'
gem 'activeadmin', github: 'Daxter/active_admin', branch: 'bugfix/1773-execjs'
gem 'meta_search', '>= 1.1.0.pre'

gem 'jquery-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'fabrication'
  gem 'capybara'
  gem 'rspec-rails'
end
