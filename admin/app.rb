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
    # enable :sessions

    # use Rack::Session::Cookie, :key => 'onecoinim',
    #     :path => '/',
    #     :expire_after => 6000

    # set :session_secret, APP_CONFIG['session_secret']
    set :sessions, domain: APP_CONFIG['cookie_domain']
    set :admin_model, 'Account'
    set :session_id, 'account_id'
    set :login_page,  '/sessions/new'

    helpers do
      # 重写方法
      def current_account
        @current_account ||= login_from_cookie
      end
    end

    # Called from #current_user.  Finaly, attempt to login by an expiring token in the cookie.
    def login_from_cookie
      session['abc'] = "abc"
      logger.info "*******     #{request.cookies['rack.session']['secure']['access_token']}  ************************"

      # user = cookies[:auth_token] && User.find_by_remember_token(cookies[:auth_token])
      # if user && user.remember_token?
      #   user.remember_me
      #   cookies[:auth_token] = { :value => user.remember_token, :expires => user.remember_token_expires_at }
      #   self.current_user = user
      # end
    end

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
