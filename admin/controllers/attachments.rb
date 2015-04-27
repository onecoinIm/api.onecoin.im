ApiOnecoinIm::Admin.controllers :attachments do
  get :index do
    @title = "Attachments"
    @attachments = Attachment.all
    render 'attachments/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'attachment')
    @attachment = Attachment.new
    render 'attachments/new', :layout => false
  end

  post :create do
    @attachment = Attachment.new(params[:attachment])
    @attachment.account = current_account
    if @attachment.save
      @title = pat(:create_title, :model => "attachment #{@attachment.id}")
      flash[:success] = pat(:create_success, :model => 'Attachment')
      redirect url(:attachments, :id => @attachment.id)
      # params[:save_and_continue] ? redirect(url(:attachments, :index)) : redirect(url(:attachments, :edit, :id => @attachment.id))
    else
      @title = pat(:create_title, :model => 'attachment')
      flash.now[:error] = pat(:create_error, :model => 'attachment')
      render 'attachments/new', :layout => false
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "attachment #{params[:id]}")
    @attachment = Attachment.find(params[:id])
    if @attachment
      render 'attachments/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'attachment', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "attachment #{params[:id]}")
    @attachment = Attachment.find(params[:id])
    if @attachment
      if @attachment.update_attributes(params[:attachment])
        flash[:success] = pat(:update_success, :model => 'Attachment', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:attachments, :index)) :
          redirect(url(:attachments, :edit, :id => @attachment.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'attachment')
        render 'attachments/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'attachment', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy, :with => :id do
    @title = "Attachments"
    attachment = Attachment.find(params[:id])
    if attachment
      if attachment.destroy
        flash[:success] = pat(:delete_success, :model => 'Attachment', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'attachment')
      end
      redirect url(:attachments, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'attachment', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Attachments"
    unless params[:attachment_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'attachment')
      redirect(url(:attachments, :index))
    end
    ids = params[:attachment_ids].split(',').map(&:strip)
    attachments = Attachment.find(ids)
    
    if Attachment.destroy attachments
    
      flash[:success] = pat(:destroy_many_success, :model => 'Attachments', :ids => "#{ids.to_sentence}")
    end
    redirect url(:attachments, :index)
  end

  # 通过js远程删除
  # get :delete, :with => :id do
  #   @attachment = Attachment.find params[:id]
  #   render 'attachments/attachment', :layout => false
  # end

  delete :delete, :with => :id do
    content_type :js
    @attachment = Attachment.find params[:id]
    @attachment.destroy
    "$('#attachment_#{@attachment.id}').html('<del> #{@attachment.file} 附件已被删除</del>')"
  end
end
