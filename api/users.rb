# encoding: utf-8

module ApiOnecoinIm
  class Api
    resource :users do

      desc "注册用户."
      post do
        @account = Account.new(params[:user])
        @account.role = 'commenter' #默认
        if @account.save

          # session[:account_id] = @account.id #这样才可以与padrino-access衔接上
          # response.set_cookie('user', {:value => @account.encrypt_cookie_value, :path => "/", :expires => 2.weeks.since, :httponly => true}) if params[:remember_me]

          {:user => @account, :success => t(:signup_success)}
        else
          error!({ "errors" => @account.errors}, 422)
        end
      end
    end
  end
end