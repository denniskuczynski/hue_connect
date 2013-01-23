$(document).ready(function() {
  HueConnect.mainRouter = new HueConnect.Routers.MainRouter();
  Backbone.history.start({pushState: true});
});