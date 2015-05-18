source 'http://ruby.taobao.org'

# Project requirements
gem 'rake'
gem 'tilt', '~> 1.4.1'

## Padrino Stable Gem
gem 'padrino', '~> 0.12.5'

# Component requirements
gem 'bcrypt'
gem 'erubis', '~> 2.7.0'
gem 'activerecord', '~> 3.2', :require => 'active_record'
gem 'mysql2'
gem 'dalli', :require => 'active_support/cache/dalli_store'
gem 'kgio'
gem "second_level_cache", :git => "https://github.com/csdn-dev/second_level_cache.git"
gem 'acts-as-taggable-on', :git => "https://github.com/robbin/acts-as-taggable-on.git"
gem 'github-markdown', :require => 'github/markdown'
gem 'will_paginate', :require => ['will_paginate/active_record', 'will_paginate/view_helpers/sinatra']
gem 'sanitize'
gem 'carrierwave', :require => ['carrierwave', 'carrierwave/orm/activerecord']
gem 'mini_magick'
gem 'rest-client'

## api requirements
gem 'grape'
gem 'grape-rabl'
gem 'rack-cors', :require => 'rack/cors'
gem 'padrino-warden'

## 使用类似devise认证管理插件
# gem 'padrino-responders', :git => 'https://github.com/bookworm/padrino-responders.git'
# gem 'revise'

# Production requirements
group :production do
  gem 'zbatery'
  gem 'rainbows'
end

# Development requirements
group :development do
  gem 'pry-padrino'

  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-nginx', '~> 2.0'
end

# Test requirements
group :test do
  gem 'minitest', "~>2.6.0", :require => "minitest/autorun"
  gem 'rack-test', :require => "rack/test"
  gem 'factory_girl'
  gem 'database_cleaner'
end