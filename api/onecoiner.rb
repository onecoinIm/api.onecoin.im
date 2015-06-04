# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :onecoiners do

      # 地址： /api/v1/people
      # 输出： {"count":"340268"}
      desc "实时获取官网的加入人数"
      get ":id" do
        onecoiner = Onecoiner.new
        # onecoiner = {id: 1, counter: onecoiner.counter}
        # {onecoiner: onecoiner}
      end
    end
  end
end