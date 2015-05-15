# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :comments do

      desc "获得文章评论列表."
      get :rabl => "comments" do
        limit = params[:recent] || 5
        @comments = BlogComment.order('id DESC').limit(limit)
      end
    end
  end
end