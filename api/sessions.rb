# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :sessions do

      desc "登录."
      post :create do
        account = Account.authenticate(params[:email], params[:password])

        if account
          # session[:account_id] = account.id
          response.set_cookie('user', {:value => account.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]

          set_current_account(account)

          account.token = SecureRandom.hex
          # account.save!
          render json: { :access_token => account.token, :token_type => "bearer" }
        else
          render json: {:error => "Invalid Login Details"}, status: 401
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