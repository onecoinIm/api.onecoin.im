# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :sessions do

      desc "登录."
      post :create do
        account = Account.authenticate(params[:user][:email], params[:user][:password])

        if account
          # session[:account_id] = account.id
          # response.set_cookie('user', {:value => account.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]

          # set_current_account(account)

          logger.info(params[:user].to_s)

          account.token = SecureRandom.hex
          # account.save!
          {:token => account.token, :token_type => "bearer", :email => account.email, :user_id => account.id }
        else
          error!({ "error" => '用户名或密码不正确', "detail" => "missing widget" }, 422)
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