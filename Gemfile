source 'http://rubygems.org'

gem 'rails', '3.2.2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem "jquery-rails"
gem "mongoid", "~> 3.0.4"
gem "haml-rails"
gem 'devise'

gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'simple_form', "~> 2.0.0"
gem "responders"
gem "cancan"
gem "redcarpet"
gem "rails-backbone"
gem "rails_admin", :git => "git://github.com/sferik/rails_admin.git"
gem "bbenezech-nested_form"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
platforms :mri_19 do
  unless ENV["CI"]
    gem "ruby-debug19", :require => "ruby-debug" if RUBY_VERSION < "1.9.3"
  end
end

group :development, :test do
  gem 'thin'
  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent'
  gem 'spork', '~> 0.9.0.rc'
  gem 'guard-spork'
  gem 'growl'
  gem 'webrat'
  gem "rspec-rails", "~> 2.6"
  gem 'mongoid-rspec'
  gem "shoulda-matchers"
  gem 'database_cleaner'
  gem 'factory_girl_rails', :require => false
  gem 'capybara'
  gem 'named_let'
  gem 'i18n_generators'
end
