$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__) + '/../lib')

# config.ru
require 'hue_connect'
run HueConnect::Server