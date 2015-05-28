# Helper methods defined here can be accessed in any controller or view in the application
#
# https://github.com/fex-team/ueditor/blob/dev-1.5.0/php/Uploader.class.php
module ApiOnecoinIm
  class Admin
    module UeditorHelper

      ## 以下为3个上传核心处理方法，主要是文件处理 ##
      # 上传文件和图片
      def upload_file
        upfile = params[:upfile]
        filename = upfile[:filename]
        file = upfile[:tempfile]
        folder = upload_path + 'images'

        File.open(File.join(folder, filename), 'wb') do |f|
          f.write file.read
        end

        state_success(filename)
      end

      # 处理base64编码的图片上传
      def upload_base64

      end

      # 拉取远程图片
      def save_remote

      end

      # 处理成功返回给客户端的状态信息
      def state_success(filename)
        {
            :url => filename,
            :title => filename,
            :original => filename,
            :state => 'SUCCESS'
        }
      end

      # 上传路径 /admin/uploads
      def upload_path
        url("/uploads/")
      end

      # 对应action的配置项
      def config_of(action)
        case action
          # 上传图片
          when 'uploadimage'
            {
                "pathFormat" => config['imagePathFormat'],
                "maxSize" => config['imageMaxSize'],
                "allowFiles" => config['imageAllowFiles'],
                "fieldName" => config['imageFieldName']
            }

          # 上传涂鸦
          when 'uploadscrawl'
            settings = {
                "pathFormat" => config['scrawlPathFormat'],
                "maxSize" => config['scrawlMaxSize'],
                "allowFiles" => config['scrawlAllowFiles'],
                "oriName" => "scrawl.png"
            }
            fieldName = config['scrawlFieldName']
            base64 = "base64"

          # 上传视频
          when 'uploadvideo'
            settings = {
                "pathFormat" => config['videoPathFormat'],
                "maxSize" => config['videoMaxSize'],
                "allowFiles" => config['videoAllowFiles']
            }
            fieldName = config['videoFieldName']

          # 抓取远程图片
          when 'catchimage'
            settings = {
                "pathFormat" => config['filePathFormat'],
                "maxSize" => config['fileMaxSize'],
                "allowFiles" => config['fileAllowFiles']
            }
            fieldName = config['fileFieldName']

        end
      end
    end

    # 配置
    def config
      config = PADRINO_ROOT + url('/views/ueditor/config.json.erb')
      config = File.read(config)
      config = ERB.new(config).result
      config = JSON.parse(config)
    end

    helpers UeditorHelper
  end
end

