module HueConnect
  class Server < Sinatra::Base

    root = File.dirname(File.expand_path(__FILE__))
    set :root, root
    set :public_folder, File.dirname(__FILE__) + '/../../app/'

    get "/configuration" do
      headers['Access-Control-Allow-Origin'] = '*'
      content_type :json
      configuration = HueConnect::Configuration.new
      configuration.to_json
    end

    post "/discover" do
      headers['Access-Control-Allow-Origin'] = '*'
      content_type :json
      configuration = HueConnect::Configuration.new
      hub_ip = HueConnect::Discovery.find_hub
      if hub_ip
        hub = HueConnect::HueHub.new(hub_ip, nil)
        username = hub.set_new_username()

        configuration.hub_ip = hub_ip
        configuration.username = username
        configuration.save
      end
      configuration.to_json
    end

    get '/hub_info' do
      headers['Access-Control-Allow-Origin'] = '*'
      content_type :json
      configuration = HueConnect::Configuration.new
      hub = HueConnect::HueHub.new(configuration.hub_ip, configuration.username)
      hub.get_info.to_json
    end

    post "/adjust_light" do
      headers['Access-Control-Allow-Origin'] = '*'
      index = params[:index].to_i
      changes = format_changes(params[:changes] || {})
      content_type :json
      configuration = HueConnect::Configuration.new
      hub = HueConnect::HueHub.new(configuration.hub_ip, configuration.username)
      return hub.adjust_light(index, changes).to_json
    end

    private

    def format_changes(changes)
      changes['on'] = changes['on'] == 'true' if changes['on']
      changes['bri'] = changes['bri'].to_i if changes['bri']
      changes['ct'] = changes['ct'].to_i if changes['ct']
      changes['sat'] = changes['sat'].to_i if changes['sat']
      changes['hue'] = changes['hue'].to_i if changes['hue']
      changes
    end
    
  end
end