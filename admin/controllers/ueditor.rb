ApiOnecoinIm::Admin.controllers :ueditor do
  disable :layout

  # 列表 get: actions
  get :index, :provides => [:json] do
    content_type :json

    case params[:action]
      when 'config'
        @uploads = upload_path #上传的全部文件在 `/admin/uploads` 下
        render 'config'

      when 'listfile'
        logger.info 'Please listfile.'

      when 'listimage'
        list_images

    end
  end

  # 上传 post: actions
  post :index, :provides => [:json] do
    content_type :json

    result = case params[:action]
               # 上传图片
               when 'uploadimage'
                 upload_file

               when 'uploadscrawl'
                 logger.info 'Please uploadscrawl.'
                 upload_file

               when 'uploadvideo'
                 logger.info 'Please uploadvideo.'
                 upload_file

               when 'catchimage'
                 logger.info 'Please catchimage.'
                 upload_base64

               else
                 {:state => '请求地址出错'}
             end

    result.to_json
  end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
end

# {:filename => "qrcode_for_gh_792a41c491a6_258.jpg",
#  :type => "image/jpeg",
#  :name => "upfile",
#  :tempfile =>
#            #<Tempfile:/tmp/RackMultipart20150527-4380-1id1yaj>,
#            # :head=>"Content-Disposition: form-data;
#            # name=\"upfile\";
#            # filename=\"qrcode_for_gh_792a41c491a6_258.jpg\"\r\n
#            # Content-Type: image/jpeg\r\n"}
