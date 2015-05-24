# encoding: utf-8

module ApiOnecoinIm
  class Api

    resource :blogs do
      # before do
      #   # warden.authenticate! :scope => :public
      # end

      desc "获得文章列表."
      get :rabl => "blogs" do
        #
        # hot_blogs:传参数 ?hot=1 或其他数值
        #

        @blogs = if params[:hot]
          Blog.hot_blogs(params[:hot])
        else
          Blog.order('id DESC').page(params[:page])
        end
      end

      get ':id', :rabl => "blog" do
        @blog = Blog.find(params[:id])
        @blog
      end

      put ':id', :rabl => "blog"  do
        @blog = Blog.find(params[:id])
        @blog.increment_view_count
        @blog
      end

      # get :quote_comment, :map => '/comment/quote' do
      #   return false unless account_login?
      #   return false unless params[:id]
      #   comment = BlogComment.find params[:id].to_i
      #   body = "\n> #{comment.account.name} 评论:\n"
      #   comment.content.gsub(/\n{3,}/, "\n\n").split("\n").each { |line| body << "> #{line}\n" }
      #   body
      # end
      #
      # post :comment_preview, :map => '/comment/preview' do
      #   return false unless account_login?
      #   Sanitize.clean(GitHub::Markdown.to_html(params[:term], :gfm), Sanitize::Config::RELAXED) if params[:term]
      # end
      #
      # post :create_comment, :map => '/blog/:id/comments' do
      #   content_type :js
      #   halt 401 unless account_login?
      #   blog = Blog.find params[:id]
      #   halt 403 unless blog.commentable?
      #   @comment = blog.comments.create(:account => current_account, :content => params[:blog_comment][:content])
      #   render 'blog/create_comment'
      # end
      #
      # delete :comment, :map => '/comment/:id' do
      #   content_type :js
      #   comment = BlogComment.find params[:id]
      #   if account_admin? || (account_commenter? && comment.account == current_account)
      #     comment.destroy
      #     "$('div#comments>ul>li##{comment.id}').fadeOut('slow', function(){$(this).remove();});"
      #   else
      #     halt 403
      #   end
      # end
    end



  end
end