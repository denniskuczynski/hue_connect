module HueConnect
  class Server < Sinatra::Base
    helpers Sinatra::Cookies

    get "/" do
      @configuration = HueConnect::Configuration.new
      if @configuration.hub_ip and @configuration.username
         hub = HueConnect::HueHub.new(@configuration.hub_ip, @configuration.username)
         @hub_info = hub.get_info
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
    
    post "/adjust" do
      configuration = HueConnect::Configuration.new
      hub = HueConnect::HueHub.new(configuration.hub_ip, configuration.username)
      convert_adjust_params(params)
      index = remove_index_param(params)
      if hub.adjust_light(index, params)
        redirect_to_root "Light successfully adjusted - #{params}"
      else
        redirect_to_root "Unable to adjust light"
      end
    end
    
    post "/adjust-all" do
      configuration = HueConnect::Configuration.new
      hub = HueConnect::HueHub.new(configuration.hub_ip, configuration.username)
      convert_adjust_params(params)
      if not hub.adjust_all_lights(params).include? nil
        redirect_to_root "Lights successfully adjusted - #{params}"
      else
        redirect_to_root "Unable to adjust lights"
      end
    end

    private

    def url_path(*path_parts)
      [ path_prefix, path_parts ].join("/").squeeze('/')
    end
    alias_method :u, :url_path
    
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
    
    # Convert Form String Values to Appropriate Types
    def convert_adjust_params(params)
      params['on'] = params['on'] == 'true' if params['on']
      params['bri'] = params['bri'].to_i if params['bri']
      params['ct'] = params['ct'].to_i if params['ct']
      params['sat'] = params['sat'].to_i if params['sat']
      params['hue'] = params['hue'].to_i if params['hue']
    end
    
    def remove_index_param(params)
      params.delete('index')
    end

  end
end