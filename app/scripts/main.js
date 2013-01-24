$(document).ready(function() {
  HueConnect.vent = _.extend({}, Backbone.Events);
  HueConnect.mainRouter = new HueConnect.Routers.MainRouter();
  
  Backbone.history.start({pushState: false});
});