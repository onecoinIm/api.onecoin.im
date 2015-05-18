# encoding: utf-8
require 'grape'
require 'warden-oauth2'

module ApiOnecoinIm
  class Api < Grape::API
    # 修改cookie与客户端一致
    use Rack::Session::Cookie, :key => 'im_onecoin',
        # :domain => '',
        :path => '/',
        :expire_after => 600,
        :secret => 'change_me',
        :old_secret => 'also_change_me'

    # helpers Padrino::Mailer
    helpers Padrino::Helpers

    #GrapeApi设置
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Rabl

    # fixme
    # 添加Api认证
    # 参考：https://ruby-china.org/topics/14656
    use Warden::Manager do |config|
      config.strategies.add :bearer, Warden::OAuth2::Strategies::Bearer
      config.strategies.add :client, Warden::OAuth2::Strategies::Client
      config.strategies.add :public, Warden::OAuth2::Strategies::Public

      config.default_strategies :bearer, :client, :public
      config.failure_app = Warden::OAuth2::FailureApp
    end

    helpers do
      def warden; env['warden'] end
    end

  end
end
