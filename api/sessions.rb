# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :sessions do

      desc "登录."
      post :create do
        if params[:username] && params[:password]
          account = Account.authenticate(params[:username], params[:password])
          if account
            account.token = SecureRandom.hex
            # account.token = account.encrypt_cookie_value

            account.save!
            {:access_token => account.token, :token_type => "bearer"}
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