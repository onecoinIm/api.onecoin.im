ApiOnecoinIm::Admin.controllers :sessions do
  # login
  get :new do
    render "/sessions/new", nil, :layout => false
  end

  post :create do
    if account = Account.authenticate(params[:email], params[:password])

      # session[:account_id] = account.id
      response.set_cookie('user', {:value => account.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]

      set_current_account(account)

      redirect url(:base, :index)
    elsif Padrino.env == :development && params[:bypass]
      account = Account.first
      set_current_account(account)
      redirect url(:base, :index)
    else
      params[:email] = h(params[:email])
      flash.now[:error] = pat('login.error')
      render "/sessions/new", nil, :layout => false
    end
  end

  # logout
  delete :destroy do
    set_current_account(nil)
    redirect url(:sessions, :new)
  end
end
