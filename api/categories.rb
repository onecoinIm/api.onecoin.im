# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :categories do

      desc "获得类别列表."
      get :rabl => "categories" do
        @categories = Category.all
      end
    end
  end
end