# encoding: utf-8
require 'rubygems'
require 'mechanize'

module ApiOnecoinIm
  class Api
    resource :onecoiners do

      # 地址： /api/v1/people
      # 输出： {"count":"340268"}
      desc "实时获取官网的加入人数"
      get do
        onecoiners = Onecoiner.new.all

        # {onecoiners:[{id: 1, counter: onecoiners}]}
        # {onecoiner: {id: 1, counter: onecoiners}}
        {counter: onecoiners}
      end
    end
  end
end