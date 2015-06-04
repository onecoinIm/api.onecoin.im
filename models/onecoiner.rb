
require 'rubygems'
require 'mechanize'

class Onecoiner
  # include Scrapify::Base
  # html "https://www.onecoin.eu/tech/other/getJoinedPeople"
  #
  # attribute :counter, css: "body"
  #
  # key :counter

  a = Mechanize.new { |agent|
    agent.user_agent_alias = 'Mac Safari'
  }

  a.get('https://www.onecoin.eu/tech/other/getJoinedPeople') do |page|
    p page.body
    page.body
  end
end

