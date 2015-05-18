# encoding: utf-8
# require 'warden'

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
    helpers Padrino::Warden

    #GrapeApi设置
    version 'v1', using: :path
    format :json
    formatter :json, Grape::Formatter::Rabl

    # 添加Api认证
    # https://github.com/jondot/padrino-warden
    # https://github.com/althafhameez/authenticating_api_rails_devise/blob/master/app/api/api.rb
    # https://github.com/geekazoid/grape-warden/blob/master/app/my_api.rb [use]
    # Configure Warden
    use Warden::Manager do |config|
      config.scope_defaults :default,
                            # Set your authorization strategy
                            strategies: [:my_token]
                            # Route to redirect to when warden.authenticate! returns a false answer.
                            # action: '/unauthenticated'
      config.failure_app = lambda { |env| [401, {}, ["Not authorized"]] }
    end
    #
    Warden::Strategies.add(:my_token) do
      def valid?
        # Validate that the access token is properly formatted.
        # Currently only checks that it's actually a string.
        request.env["HTTP_AUTH_TOKEN"].is_a?(String)
      end

      def authenticate!
        token = env['HTTP_AUTH_TOKEN'] || env['rack.request.query_hash']['AUTH_TOKEN']
        if token == 'abc123'
          logger.info("*************************************************************")
          success!(Account.new)
        else
          logger.info("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
          throw :warden
        end
      end
    end
  end
end
