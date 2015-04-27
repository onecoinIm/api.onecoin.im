ApiOnecoinIm::OnecoinIm.controllers :accounts do
  get :new, :map => '/signup' do
    @title = t(:new_title, :model => 'account')
    @account = Account.new
    render 'accounts/new'
  end

  post :create do
    @account = Account.new(params[:account])
    @account.role = 'commenter' #默认
    if @account.save
      @title = t(:create_title, :model => "account #{@account.id}")

      session[:account_id] = @account.id #这样才可以与padrino-access衔接上
      response.set_cookie('user', {:value => @account.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]

      flash[:success] = t(:signup_success)
      redirect(url("/admin"))
    else
      @title = t(:create_title, :model => 'account')
      flash.now[:error] = t(:signup_error)
      render 'accounts/new'
    end
  end
end
