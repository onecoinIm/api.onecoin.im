# encoding: utf-8
require 'rubygems'
require 'mechanize'

# 参考
# https://github.com/CloCkWeRX/toowoomba/blob/master/scraper.rb
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
I_KNOW_THAT_OPENSSL_VERIFY_PEER_EQUALS_VERIFY_NONE_IS_WRONG = nil

class Onecoiner
  attr_accessor :uri, :agent

  def initialize
    @uri = 'https://www.onecoin.eu/tech/other/getJoinedPeople'
    @agent = 'Mac Safari'
  end

  def mechanize
    Mechanize.new do |m|
      m.user_agent_alias = agent

      # http://sinyt.hateblo.jp/entry/2013/12/24/203528
      m.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
  end

  def all
    result = nil
    mechanize.get(uri) do |page|
      begin
        result = page.body.strip

      rescue
        return result

      end
    end

    result
  end
end

