ApiOnecoinIm::Admin.controllers :base do
  get :index, :map => "/" do
    @title = "维卡币操盘手管理后台"

    @blogs = of_current_account(:blogs).order('id DESC').page(params[:page]).per_page(100)
    @comments = of_current_account(:blog_comments).order('id DESC').page(params[:page]).per_page(100)

    render "base/index"
  end
end
