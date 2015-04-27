ApiOnecoinIm::Admin.controllers :blog_comments do
  get :index do
    @title = "Blog_comments"
    @blog_comments = of_current_account(:blog_comments).order('id DESC').page(params[:page]).per_page(100)
    render 'blog_comments/index'
  end

  # 应该在公共页用
  # get :new do
  #   @title = pat(:new_title, :model => 'blog_comment')
  #   @blog_comment = BlogComment.new
  #   render 'blog_comments/new'
  # end

  # post :create do
  #   @blog_comment = BlogComment.new(params[:blog_comment])
  #   if @blog_comment.save
  #     @title = pat(:create_title, :model => "blog_comment #{@blog_comment.id}")
  #     flash[:success] = pat(:create_success, :model => 'BlogComment')
  #     params[:save_and_continue] ? redirect(url(:blog_comments, :index)) : redirect(url(:blog_comments, :edit, :id => @blog_comment.id))
  #   else
  #     @title = pat(:create_title, :model => 'blog_comment')
  #     flash.now[:error] = pat(:create_error, :model => 'blog_comment')
  #     render 'blog_comments/new'
  #   end
  # end

  # get :edit, :with => :id do
  #   @title = pat(:edit_title, :model => "blog_comment #{params[:id]}")
  #   @blog_comment = BlogComment.find(params[:id])
  #   if @blog_comment
  #     render 'blog_comments/edit'
  #   else
  #     flash[:warning] = pat(:create_error, :model => 'blog_comment', :id => "#{params[:id]}")
  #     halt 404
  #   end
  # end

  # put :update, :with => :id do
  #   @title = pat(:update_title, :model => "blog_comment #{params[:id]}")
  #   @blog_comment = BlogComment.find(params[:id])
  #   if @blog_comment
  #     if @blog_comment.update_attributes(params[:blog_comment])
  #       flash[:success] = pat(:update_success, :model => 'Blog_comment', :id =>  "#{params[:id]}")
  #       params[:save_and_continue] ?
  #         redirect(url(:blog_comments, :index)) :
  #         redirect(url(:blog_comments, :edit, :id => @blog_comment.id))
  #     else
  #       flash.now[:error] = pat(:update_error, :model => 'blog_comment')
  #       render 'blog_comments/edit'
  #     end
  #   else
  #     flash[:warning] = pat(:update_warning, :model => 'blog_comment', :id => "#{params[:id]}")
  #     halt 404
  #   end
  # end

  delete :destroy, :with => :id do
    @title = "Blog_comments"
    blog_comment = of_current_account(:blog_comments).find(params[:id])
    if blog_comment
      if blog_comment.destroy
        flash[:success] = pat(:delete_success, :model => 'Blog_comment', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'blog_comment')
      end
      redirect url(:blog_comments, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'blog_comment', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Blog_comments"
    unless params[:blog_comment_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'blog_comment')
      redirect(url(:blog_comments, :index))
    end
    ids = params[:blog_comment_ids].split(',').map(&:strip)
    blog_comments = BlogComment.find(ids)
    
    if BlogComment.destroy blog_comments
    
      flash[:success] = pat(:destroy_many_success, :model => 'Blog_comments', :ids => "#{ids.to_sentence}")
    end
    redirect url(:blog_comments, :index)
  end
end
