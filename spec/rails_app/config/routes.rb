HueConnect::RailsApp.routes.draw do
  mount HueConnect::Server, :at => "/hue"
end