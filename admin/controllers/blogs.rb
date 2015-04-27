ApiOnecoinIm::Admin.controllers :blogs do
  # todo
  # before do
  #   halt 403 unless account_admin?
  # end

  get :index do
    @title = "Blogs"
    @blogs = of_current_account(:blogs).order('id DESC').page(params[:page]).per_page(100)
    render 'blogs/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'blog')
    @blog = Blog.new
    @attachments = current_account.attachments.orphan
    render 'blogs/new'
  end

  post :create do
    @blog = Blog.new(params[:blog])
    @blog.account = current_account
    if @blog.save
      @title = pat(:create_title, :model => "blog #{@blog.id}")
      @blog.attach!(current_account)
      ping_search_engine(@blog) if APP_CONFIG['blog_search_ping'] # only ping search engine in production environment
      flash[:success] = pat(:create_success, :model => 'Blog')
      params[:save_and_continue] ? redirect(url(:blogs, :index)) : redirect(url(:blogs, :edit, :id => @blog.id))
      # redirect url(:blog, :show, :id => @blog.id)
    else
      @title = pat(:create_title, :model => 'blog')
      flash.now[:error] = pat(:create_error, :model => 'blog')
      render 'admin/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "blog #{params[:id]}")
    @blog = of_current_account(:blogs).find(params[:id])
    @attachments = current_account.attachments.where(:blog_id => [nil, @blog.id]).order('id ASC')
    if @blog
      render 'blogs/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'blog', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "blog #{params[:id]}")
    @blog = of_current_account(:blogs).find(params[:id])
    if @blog
      if @blog.update_blog(params[:blog])
        @blog.attach!(current_account)
        flash[:success] = pat(:update_success, :model => 'Blog', :id => "#{params[:id]}")
        params[:save_and_continue] ?
            redirect(url(:blogs, :index)) :
            redirect(url(:blogs, :edit, :id => @blog.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'blog')
        render 'blogs/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'blog', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Blogs"
    blog = of_current_account(:blogs).find(params[:id])
    if blog
      if blog.destroy
        flash[:success] = pat(:delete_success, :model => 'Blog', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'blog')
      end
      redirect url(:blogs, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'blog', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Blogs"
    unless params[:blog_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'blog')
      redirect(url(:blogs, :index))
    end
    ids = params[:blog_ids].split(',').map(&:strip)
    blogs = of_current_account(:blogs).find(ids)

    if Blog.destroy blogs

      flash[:success] = pat(:destroy_many_success, :model => 'Blogs', :ids => "#{ids.to_sentence}")
    end
    redirect url(:blogs, :index)
  end

  post :preview do
    GitHub::Markdown.to_html(params[:term], :gfm) if params[:term]
  end
end
