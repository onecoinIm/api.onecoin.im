# encoding: utf-8

ApiOnecoinIm::Admin.helpers do
  # current_account's blogs,blog_comments...
  def of_current_account(models)
    models = models.to_s
    if current_account && current_account.admin?
      models.camelize.singularize.constantize
    elsif current_account.respond_to?(models)
      current_account.send(models)
    end
  end

  def content_html_safe_of(blog, method)
    if blog.respond_to?(method) && blog.send(method)
      blog.send(method).html_safe
    else
      nil
    end
  end

  # 暂时不添加Category模型
  # category = {
  #   1 ： announcement, #通告
  #   2 ： manual,       #秘籍
  #   3 ： news,         #新闻
  #   4 ： tutorial,     #教程
  # }
  def categories
    Category.all.collect do |p|
      [t(p.name), p.id] if current_account.admin? || p.role != 'admin'
    end.compact
  end
end