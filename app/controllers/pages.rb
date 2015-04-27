ApiOnecoinIm::OnecoinIm.controllers :pages do

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  get :index, :map => '/', :with => :slug_url do
    @nav = params[:slug_url]
    @page = Page.find_by_url(params[:slug_url])
    if @page
      render 'pages/index'
    else
      render 'error/404'
    end

  end
end
