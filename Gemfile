source 'https://rubygems.org'

gemspec

group :development do
  gem 'bundler'
  gem 'rake'
end

group :test do
  gem 'minitest', '~> 5.3'
  if RUBY_VERSION < '2.1.0'
    gem 'escape_utils', '~> 0.3', :require => false
    gem 'github-linguist', '~> 2.6.2', :require => false
  else
    gem 'escape_utils', '~> 1.0', :require => false
    gem 'github-linguist', '~> 2.10', :require => false
  end
  gem 'sanitize', '~> 2.0', :require => false
end
