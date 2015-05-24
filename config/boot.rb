# Defines our constants
RACK_ENV = ENV['RACK_ENV'] ||= 'development' unless defined?(RACK_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, RACK_ENV)

##
# ## Enable devel logging
#
# Padrino::Logger::Config[:development][:log_level]  = :devel
# Padrino::Logger::Config[:development][:log_static] = true
#
# 记录生产环境下的log
Padrino::Logger::Config[:production] = {:log_level => :devel, :format_datetime => " [%Y-%m-%d %H:%M:%S] ", :stream => :to_file}

# 语言文件，默认放在#{PADRINO_ROOT}/【app】/locale之下，可以作为全局使用，因此不需要再设置
# Dir.glob(File.expand_path("#{PADRINO_ROOT}/locale", __FILE__) + '/**/*.yml').each do |file|
#   I18n.load_path << file
# end

# ## Configure your HTML5 data helpers
#
# Padrino::Helpers::TagHelpers::DATA_ATTRIBUTES.push(:dialog)
# text_field :foo, :dialog => true
# Generates: <input type="text" data-dialog="true" name="foo" />
#
# ## Add helpers to mailer
#
# Mail::Message.class_eval do
#   include Padrino::Helpers::NumberHelpers
#   include Padrino::Helpers::TranslationHelpers
# end

##
# Add your before (RE)load hooks here
#
Padrino.before_load do
  # Configure your I18n
  I18n.default_locale = 'zh_cn'

  #fixme 暂时解决  bundle exec rake routes 命令错误。
  # https://github.com/eivan/PadrinoEatsGrape/issues/2
  class Grape::Route
    def name
      "API-#{route_version}" #命名路由应该无法使用了
    end

    def request_methods
      Set.new [route_method]
    end

    def original_path
      route_path
    end

    def controller
      name
    end
  end
end

##
# Add your after (RE)load hooks here
#
Padrino.after_load do
  # 解决'could not obtain a database connection within 5 seconds错误
  # 参考：http://stackoverflow.com/questions/13675879/activerecordconnectiontimeouterror
  ActiveRecord::Base.clear_active_connections!
end

# load project config
APP_CONFIG = YAML.load_file(File.expand_path("#{PADRINO_ROOT}/config", __FILE__) + '/app_config.yml')[RACK_ENV]

# initialize memcache and ActiveRecord Cache
Dalli.logger = logger
APP_CACHE = ActiveSupport::Cache::DalliStore.new("127.0.0.1")
CACHE_PREFIX = "onecoinim"
SecondLevelCache.configure do |config|
  config.cache_store = APP_CACHE
  config.logger = logger
  config.cache_key_prefix = CACHE_PREFIX
end

# Set acts_as_taggable
ActsAsTaggableOn.remove_unused_tags = true
ActsAsTaggableOn.strict_case_match = true

# Set will_paginate default page number
WillPaginate.per_page = 15

# Set carrierwave sanitize
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

Padrino.load!