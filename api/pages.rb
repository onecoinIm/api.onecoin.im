# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :pages do

      desc "获得静态页面列表."
      get :rabl => "pages" do
        @pages = Page.all
      end

      get ':id', :rabl => "page" do
        @page = Page.find(params[:id])
      end
    end

  end
end