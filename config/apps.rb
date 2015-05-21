Padrino.configure_apps do
  # 这里可以设置全局使用的参数
  disable :sessions
end

# Mounts the core application for this project

Padrino.mount('ApiOnecoinIm::Api', :app_file => Padrino.root('api/app.rb')).to('/api')

Padrino.mount("ApiOnecoinIm::Admin", :app_file => Padrino.root('admin/app.rb')).to("/admin")

# fixme delete
# Padrino.mount('ApiOnecoinIm::OnecoinIm', :app_file => Padrino.root('app/app.rb')).to('/app')
# Padrino.mount('ApiOnecoinIm::Emberjs', :app_file => Padrino.root('emberjs/app.rb')).to('/')
