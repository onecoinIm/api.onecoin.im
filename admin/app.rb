module ApiOnecoinIm
  class Admin < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    # 修改cookie与客户端一致
    # use Rack::Session::Cookie, :key => 'im_onecoin',
    #     # :domain => '',
    #     :path => '/',
    #     :expire_after => 6000,
    #     :secret => 'change_me',
    #     :old_secret => 'also_change_me'

    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl
    register WillPaginate::Sinatra

    set :admin_model, 'Account'
    # set :session_id, 'account_id'
    set :login_page,  '/sessions/new'

    # enable :sessions
    # enable :store_location

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/sessions'
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
    error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
    error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
    error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }
  end
end
