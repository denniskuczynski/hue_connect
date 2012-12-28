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
      @configuration = HueConnect::Configuration.new
      if @configuration.hub_ip and @configuration.username
         hub = HueConnect::HueHub.new(@configuration.hub_ip, @configuration.username)
         @lights = hub.get_info
      end
      erb :index
    end
    
    post "/discover" do
      hub_ip = HueConnect::Discovery.search
      if hub_ip
        configuration = HueConnect::Configuration.new
        configuration.hub_ip = hub_ip
        if not configuration.username
          hub = HueConnect::HueHub.new(hub_ip, nil)
          username = hub.set_new_username
          if not username
            redirect_to_root "Unable to set username.  Please press Hue Hub button and retry."
          else
            configuration.username = username
            configuration.save
            redirect_to_root "Updated Hue Hub IP: #{hub_ip} and Username: #{username}"
          end
        else
          configuration.save
          redirect_to_root "Updated Hue Hub IP: #{hub_ip}"
        end
      else
        redirect_to_root "Unable to find Hue Hub IP"
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
    
    def redirect_to_root(message)
      cookies[:hue_connect_notice] = message
      redirect url("/")
    end

  end
end