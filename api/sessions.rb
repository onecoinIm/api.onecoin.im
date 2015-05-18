# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :sessions do

      desc "登录."
      post :create do
        if params[:user][:email] && params[:user][:password]
          account = Account.authenticate(params[:user][:email], params[:user][:password])
          if account
            #后台需要
            # session[:account_id] = account.id
            # response.set_cookie('user', {:value => account.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]
            #
            # set_current_account(account)

            account.token = account.encrypt_cookie_value

            #fixme 需要保存到服务器吗？
            # account.save!
            {:token => account.token, :token_type => "bearer", :path => "/", :expires => 600, :httponly => true, :email => account.email, :user_id => account.id}
          else
            error!({"error" => '用户名或密码不正确'}, 422)
          end
        else
          error!({"error" => '用户名或密码不能为空'}, 422)
        end
      end

      # logout
      # delete :destroy do
      #   set_current_account(nil)
      #   redirect url(:sessions, :new)
      # end
    end

  end
end