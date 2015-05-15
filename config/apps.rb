Padrino.configure_apps do
  # enable :sessions
  set :session_secret, APP_CONFIG['session_secret']
end

# Mounts the core application for this project

Padrino.mount('ApiOnecoinIm::Api', :app_file => Padrino.root('api/app.rb')).to('/api')

Padrino.mount("ApiOnecoinIm::Admin", :app_file => Padrino.root('admin/app.rb')).to("/admin")

Padrino.mount('ApiOnecoinIm::OnecoinIm', :app_file => Padrino.root('app/app.rb')).to('/app')

# fixme delete
# Padrino.mount('ApiOnecoinIm::Emberjs', :app_file => Padrino.root('emberjs/app.rb')).to('/')
