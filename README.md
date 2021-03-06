[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/denniskuczynski/hue_connect)

# HueConnect

Simple Sinatra endpoint for controlling Phillips Hue lights

For more info on the Hue API check out [http://rsmck.co.uk/hue](http://rsmck.co.uk/hue)

## Installation

Clone the repository on a server on the same network as your Phillips Hue Hub, then execute rackup to start the server on port 9292.
``` ruby
git clone https://github.com/denniskuczynski/hue_connect.git
cd hue_connect
bundle install
rackup
```

Browse to http://127.0.0.1:9292 and click the Discover button to setup the HueConnect config.
(This will generate a config file: hue_connect.json)

You can also execute HTTP requests programmatically to adjust the light values, for example:
```ruby
require 'net/http'

def turn_lights_red
	uri = URI.parse("http://127.0.0.1:9292/adjust-all")
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Post.new(uri.request_uri)
	parameters =  {"on"=>true, "hue"=>0, "sat"=>254, "bri"=>254, "alert"=>"none"}
	request.set_form_data(parameters)
	response = http.request(request)
	if response.code.to_i == 200
	  puts "All lights red"
	end
end

def turn_lights_green
	uri = URI.parse("http://127.0.0.1:9292/adjust-all")
	http = Net::HTTP.new(uri.host, uri.port)
	request = Net::HTTP::Post.new(uri.request_uri)
	parameters = {"on"=>true, "hue"=>24423, "sat"=>254, "bri"=>62, "alert"=>"none"}
	request.set_form_data(parameters)
	response = http.request(request)
	if response.code.to_i == 200
	  puts "All lights green"
	end
end
```

![Screenshot](http://s13.postimage.org/6m2v6ow6v/Hue_Connect_0_0_2_140542.png)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

