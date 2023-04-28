source "https://rubygems.org"
CLOUDSMITH = "https://pkgs.shopify.io/basic/gems/ruby"
ruby "3.2.2"

group :development, :test do
  gem 'tapioca', require: false
  gem 'rubocop'
  gem 'rubocop-shopify'
  gem 'smart_todo', '~> 1.3', require: false
  
  source CLOUDSMITH do
    gem 'shopify-types'
  end
end

group :test do
  gem 'minitest', '>= 5.0.0', require: false
end
