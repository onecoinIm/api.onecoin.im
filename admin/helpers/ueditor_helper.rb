# Helper methods defined here can be accessed in any controller or view in the application
#
# https://github.com/fex-team/ueditor/blob/dev-1.5.0/php/Uploader.class.php
module ApiOnecoinIm
  class Admin
    module UeditorHelper
      def _create(upfile)

        if params[:upfile]
          filename = params[:upfile][:filename]
          file = params[:upfile][:tempfile]
          folder = "#{PADRINO_ROOT}/public/admin/uploads"

          File.open(File.join(folder, filename), 'wb') do |f|
            f.write file.read
          end

          {
              url: folder + "/" + filename,
              title: filename,
              original: filename,
              state: 'SUCCESS'
          }

        else

          {
              state: 'FAILURE'
          }
        end
      end
    end

    helpers UeditorHelper
  end
end
