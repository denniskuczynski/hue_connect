module HueConnect
  class Server < Sinatra::Base
    root = File.dirname(File.expand_path(__FILE__))
    set :root, root
    set :views,  "#{root}/views"

    register Sinatra::AssetPack
    assets do
      serve '/js', from: "/resources/js"
      serve '/css', from: "/resources/css"
      
      js :application, '/js/application.js', [
        '/js/vendor/json2.js',
        '/js/vendor/jquery-1.7.1.min.js',
        '/js/vendor/bootstrap.min.js',
        '/js/vendor/hsv_to_rgb.js',
        '/js/app.js'
      ]
      css :application, '/css/application.css', [
        '/css/vendor/bootstrap.min.css',
        '/css/app.css']
    end

  end
end