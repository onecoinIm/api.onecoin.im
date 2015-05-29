# encoding: utf-8

# Helper methods defined here can be accessed in any controller or view in the application
#
# https://github.com/flyerhzm/chinese_pinyin

require 'chinese_pinyin'

module ApiOnecoinIm
  class Admin
    module BlogsHelper

      # 标题转拼音
      def title_to_slug_url
        if !params[:blog][:slug_url]
          title = params[:blog][:title]
          title = Pinyin.t(title, splitter: '-')
          params[:blog][:slug_url] = title
        end
      end
    end

    helpers BlogsHelper
  end
end



