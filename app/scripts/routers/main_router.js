HueConnect.Routers.MainRouter = Backbone.Router.extend({
  routes: {
    "": "index",
    "discover": "discover",
    "info": "info"
  },

  index: function() {
    console.log("index route");
    var initializationView = new HueConnect.Views.InitializationView({});
    initializationView.render();

    xhr = $.getJSON('http://localhost:9292/configuration');
    xhr.done(function(data) {
      if (data.hub_ip == undefined || data.hub_ip == null ||
          data.username == undefined || data.username == null) {
        HueConnect.mainRouter.navigate('discover', {trigger: true});
      } else {
        HueConnect.mainRouter.navigate('info', {trigger: true});
      }
    });
  },
  
  discover: function() {
    var discoveryView = new HueConnect.Views.DiscoveryView({});
    discoveryView.render();
  },

  info: function() {
    var infoView = new HueConnect.Views.InfoView({});
  }
});