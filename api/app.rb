# encoding: utf-8
require 'grape'
require 'warden-oauth2'

module ApiOnecoinIm
  class Api < Grape::API
    # helpers Padrino::Mailer
    helpers Padrino::Helpers

    #GrapeApi设置
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Rabl

    # fixme
    # 添加Api认证
    # 参考： http://blog.yorkxin.org/posts/2013/10/08/oauth2-ruby-and-rails-integration-review/
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

    helpers do
      # todo 使用warden.user?
      def current_user
        logger.info "**************************************************************************"
        logger.info cookies.to_s
        if cookies['rack.session']
          logger.info cookies['rack.session']
        end
        # Account.find_by_token(cookies[:in_onecoin][:secure][:access_token])
      end
    end
  end
end
