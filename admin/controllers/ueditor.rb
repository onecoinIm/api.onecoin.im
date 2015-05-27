ApiOnecoinIm::Admin.controllers :ueditor do
  disable :layout

  get :index, :provides => [:any, :json] do
    content_type :json

    case params[:action]
      when 'config'
        render 'config'

      when 'uploadimage'
        logger.info 'Please upload.'
        redirect url(:ueditor, :uploadimage)

      when 'listimage'
        logger.info 'Please listimage.'

    end
  end

  get :uploadimage do
    logger.info "I`m getting from uploadimage."
  end

  post :index, :provides => [:json] do
    content_type :json

    case params[:action]
      when 'uploadimage'
        logger.info "Uploading..."
        result = _create params[:upfile]

      when 'listimage'
        logger.info 'Please listimage.'

    end

    {json: result}
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
