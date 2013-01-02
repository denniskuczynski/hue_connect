require 'digest/md5'
require 'net/http'

module HueConnect
  class HueHub

    APP_NAME = 'HueControl'

    def initialize(hub_ip, username)
      @hub_ip = hub_ip
      @username = username
    end

    def set_new_username
      username = Digest::MD5.hexdigest(Time.new.to_s)
      uri = URI.parse("http://#{@hub_ip}/api")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri)
      parameters = {
        "username" => username, 
        "devicetype" => APP_NAME
      }
      request.body = JSON.generate(parameters)
      response = http.request(request)
      puts "Sent #{request.body} recieved #{response.body}"
      if response.code.to_i == 200
        response_json = JSON.parse(response.body)
        return username if not response_json[0]['error']
      end
      return nil
    end
    
    def get_info
      uri = URI.parse("http://#{@hub_ip}/api/#{@username}")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request(request)
      if response.code.to_i == 200
        return JSON.parse(response.body)
      end
      return nil
    end
    
    def adjust_light(index, parameters)
      uri = URI.parse("http://#{@hub_ip}/api/#{@username}/lights/#{index}/state")
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Put.new(uri.request_uri)
      request.body = JSON.generate(parameters)
      response = http.request(request)
      puts "Sent #{request.body} recieved #{response.body}"
      if response.code.to_i == 200
        return JSON.parse(response.body)
      end
      return nil
    end

  end
end