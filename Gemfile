source 'http://ruby.taobao.org'

# Project requirements
gem 'rake'
gem 'tilt', '~> 1.4.1'

## Padrino框架
gem 'padrino', '~> 0.12.5'

## 数据
gem 'bcrypt'
gem 'erubis', '~> 2.7.0'
gem 'activerecord', '~> 3.2', :require => 'active_record'
gem 'mysql2'
gem 'dalli', :require => 'active_support/cache/dalli_store'
gem 'kgio'
gem "second_level_cache", :git => "https://github.com/csdn-dev/second_level_cache.git"

## 组件
gem 'acts-as-taggable-on', :git => "https://github.com/robbin/acts-as-taggable-on.git"
gem 'github-markdown', :require => 'github/markdown'
gem 'will_paginate', :require => ['will_paginate/active_record', 'will_paginate/view_helpers/sinatra']
gem 'mini_magick'
gem 'rest-client'
gem 'sanitize' #处理html和css

## 上传
gem 'carrierwave', :require => ['carrierwave', 'carrierwave/orm/activerecord']

## 拼音
gem 'chinese_pinyin'

## Api开发
gem 'grape'
gem 'grape-rabl'
gem 'rack-cors', :require => 'rack/cors'
gem 'warden-oauth2', :git => "https://github.com/mojied/warden-oauth2.git"
gem 'scrapify'
gem 'mechanize'

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