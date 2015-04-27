# encoding: utf-8

ApiOnecoinIm::OnecoinIm.controllers :blog do

  get :index do
    @blogs = Blog.order('id DESC').page(params[:page])
    render 'blog/index'
  end

  get :tag_cloud, :map => '/tag' do
    render 'blog/tag_cloud'
  end

  get :tag, :map => '/tag/:name' do
    @blogs = Blog.tagged_with(params[:name]).order('content_updated_at DESC').page(params[:page])
    if @blogs.blank?
      halt 404
    else
      render 'blog/tag'
    end
  end

  get :show_url, :map => '/blog/:id/:url', :provides => [:html, :md] do
    @blog = Blog.find params[:id].to_i
    @nav = @blog.category.name if @blog.category
    logger.info "@nav = "
    case content_type
      when :md then
        @blog.content
      when :html then
        @blog.increment_view_count
        render 'blog/show'
    end
  end

  get :show, :map => '/blog/:id', :provides => [:html, :md] do
    @blog = Blog.find params[:id].to_i
    logger.info @nav
    redirect blog_url(@blog, mime_type = content_type), 301 unless @blog.slug_url.blank?
    case content_type
      when :md then
        @blog.content
      when :html then
        @blog.increment_view_count
        render 'blog/show'
    end
  end

  get :quote_comment, :map => '/comment/quote' do
    return false unless account_login?
    return false unless params[:id]
    comment = BlogComment.find params[:id].to_i
    body = "\n> #{comment.account.name} 评论:\n"
    comment.content.gsub(/\n{3,}/, "\n\n").split("\n").each { |line| body << "> #{line}\n" }
    body
  end

  post :comment_preview, :map => '/comment/preview' do
    return false unless account_login?
    Sanitize.clean(GitHub::Markdown.to_html(params[:term], :gfm), Sanitize::Config::RELAXED) if params[:term]
  end

  post :create_comment, :map => '/blog/:id/comments' do
    content_type :js
    halt 401 unless account_login?
    blog = Blog.find params[:id]
    halt 403 unless blog.commentable?
    @comment = blog.comments.create(:account => current_account, :content => params[:blog_comment][:content])
    render 'blog/create_comment'
  end

  delete :comment, :map => '/comment/:id' do
    content_type :js
    comment = BlogComment.find params[:id]
    if account_admin? || (account_commenter? && comment.account == current_account)
      comment.destroy
      "$('div#comments>ul>li##{comment.id}').fadeOut('slow', function(){$(this).remove();});"
    else
      halt 403
    end
  end

  # 根据类别展示内容
  get :announcement, :map => '/announcement' do
    @nav = 'announcement'
    @desc = '官方网站的英文通告，翻译软件提供的翻译晦涩难懂。我们设专人，完全通过人工翻译成中文，欢迎查看。'
    @blogs = Category.blogs_of('announcement').page(params[:page])
    render 'blog/index'
  end

  get :manual, :map => '/manual' do
    @nav = 'manual'
    @desc = '投资要做到少花钱、多挣钱，需要智慧。本栏目会定期分享我们团队具体的操盘技巧，帮您利益最大化！'
    @blogs = Category.blogs_of('manual').order('id DESC').page(params[:page])
    render 'blog/index'
  end

  get :manual, :map => '/news' do
    @nav = 'news'
    @desc = '分享一些重要的官方活动信息，扩大您的信息量！'
    @blogs = Category.blogs_of('news').order('id DESC').page(params[:page])
    render 'blog/index'
  end

  get :tutorial, :map => '/tutorial' do
    @nav = 'tutorial'
    @desc = '这里采取网上问答的形式帮您解决具体问题。网上已经有很多具体教程，我们不走、更不屑于走别人走过的路！'
    @blogs = Category.blogs_of('tutorial').page(params[:page])
    render 'blog/index'
  end

  # 开发手记
  get :blackboard, :map => '/blackboard' do
    @nav = ''  #不在导航中显示
    @desc = '记录开发点滴知识，积累多平台开发经验！'
    @blogs = Category.blogs_of('blackboard').page(params[:page])
    render 'blog/index'
  end

  # fixme 这么处理好像不可以
  # ['announcement', 'manual', 'news','tutorial'].each do |item|
  #   get item.to_sym, :map => '/#{item}' do
  #     @nav = item
  #     @blogs = Blog.all_of_category(item).order('id DESC').page(params[:page])
  #     render 'blog/index'
  #   end
  # end
end