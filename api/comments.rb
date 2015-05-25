# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :comments do

      desc "获得文章评论列表."
      get :rabl => "comments" do
        limit = params[:recent] || 5
        @comments = BlogComment.order('id DESC').limit(limit)
      end

      get ":id", :rabl => "comment" do
        @comment = BlogComment.find(params[:id])
      end

      desc "添加文章评论."
      post :rabl => "comments" do
        # halt 403 unless blog.commentable?
        @comment = BlogComment.create(params[:comment])
      end
    end
  end
end