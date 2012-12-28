module HueConnect

  class Server < Sinatra::Base
    helpers Sinatra::Cookies

    root = File.dirname(File.expand_path(__FILE__))
    set :root, root
    set :views,  "#{root}/views"
    if respond_to? :public_folder
          set :public_folder, "#{root}/resources"
        else
          set :public, "#{root}/resources"
        end
    set :static, true

    register Sinatra::AssetPack
    assets do
      js :application, '/js/application.js', [
        '/js/vendor/json2.js',
        '/js/vendor/jquery-1.7.1.min.js',
        '/js/vendor/bootstrap.min.js',
        '/js/app.js'
      ]
      css :application, '/css/application.css', [
        '/css/vendor/bootstrap.min.css',
        '/css/app.css']
    end

    get "/" do
      begin
        erb :index
      end
    end

    def url_path(*path_parts)
      [ path_prefix, path_parts ].join("/").squeeze('/')
    end
    alias_method :u, :url_path

    private

    def path_prefix
      request.env['SCRIPT_NAME']
    end

    def notice_message
      message = cookies[:hue_connect_notice]
      cookies[:hue_connect_notice] = ''
      message
    end

  end
end