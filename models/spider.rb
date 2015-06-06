# encoding: utf-8
require 'rubygems'
require 'mechanize'

# 参考
# https://github.com/CloCkWeRX/toowoomba/blob/master/scraper.rb
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil

class Spider
  attr_accessor :uri, :browser

  def initialize(url, browser = nil)
    @uri = url
    @browser = browser || 'Mac Safari'
    # abort "#{$0} login passwd" if (ARGV.size != 2)
  end

  def mechanize
    Mechanize.new do |agent|
      agent.user_agent_alias = browser

      # Flickr refreshes after login
      agent.follow_meta_refresh = true

      # http://sinyt.hateblo.jp/entry/2013/12/24/203528
      agent.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end

  def all
    result = nil
    mechanize.get(uri) do |home_page|
      signin_page = mechanize.click(home_page.link_with(:text =>  /'管理登录'/))

      my_page = signin_page.form_with(:name => 'login_form') do |form|
        form.loginSacct  =  "username"
        form.loginPwd = "password"
      end.submit

      logger.info(my_page)
    end
    result
  end
end

