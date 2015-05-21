module ApiOnecoinIm
  class Admin < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl
    register WillPaginate::Sinatra

    #
    # 多应用共享cookie
    # https://github.com/padrino/padrino-framework/issues/1322
    disable :sessions

    access_control.roles_for :any do |role|
      role.protect '/'
    end

    access_control.roles_for :commenter do |role|
      role.project_module :blogs, '/blogs'
      role.project_module :blog_comments, '/blog_comments'
      role.allow   '/accounts/edit'
    end

    access_control.roles_for :admin do |role|
      role.project_module :blogs, '/blogs'
      role.project_module :pages, '/pages'
      role.project_module :blog_comments, '/blog_comments'
      role.project_module :categories, '/categories'
      role.project_module :attachments, '/attachments'
      role.project_module :accounts, '/accounts'
    end

    # Custom error management
    error(401) { @title = "Error 401"; render('errors/401', :layout => :error) }
    error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
    error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
    error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }
  end
end
