module HueConnect
  class Configuration
    attr_accessor :hub_ip, :username

    CONFIGURATION_FILE_PATH = './hue_connect.json'

    def initialize
      read_configuration
    end

    def save
      write_configuration
    end

    def to_json
      {
        'hub_ip' => @hub_ip,
        'username' => @username
      }.to_json
    end

    private
    
    def read_configuration
      if File.exist?(CONFIGURATION_FILE_PATH)
        configuration = JSON.parse(File.open(CONFIGURATION_FILE_PATH, "r").read)
        @hub_ip = configuration['hub_ip']
        @username = configuration['username']
      end
    end
    
    def write_configuration
      configuration = 
      File.open(CONFIGURATION_FILE_PATH, 'w') {|f| f.write(self.to_json) }
    end

  end
end