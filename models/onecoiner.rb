class Onecoiner
  include Scrapify::Base
  html "https://www.onecoin.eu/tech/other/getJoinedPeople"

  attribute :counter, css: "body"

  key :counter
end