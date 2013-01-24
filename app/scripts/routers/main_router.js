HueConnect.Routers.MainRouter = Backbone.Router.extend({
  routes: {
    "": "index",
    "discover": "discover",
    "main": "main"
  },

  currentView: null,

  initialize: function() {
    HueConnect.vent.on("configuration:invalid", function(){
      HueConnect.mainRouter.navigate('discover', {trigger: true});
    });
    HueConnect.vent.on("configuration:valid", function(){
      HueConnect.mainRouter.navigate('main', {trigger: true});
    });
  },

  index: function() {
    if (this.currentView !== null) {
      this.currentView.dispose();
    }
    this.currentView = new HueConnect.Views.InitializationView({});
    this.currentView.render();
    this.currentView.getConfiguration();
  },
  
  discover: function() {
    if (this.currentView !== null) {
      this.currentView.dispose();
    }
    this.currentView = new HueConnect.Views.DiscoveryView({});
    this.currentView.render();
  },

  main: function() {
    if (this.currentView !== null) {
      this.currentView.dispose();
    }
    this.currentView = new HueConnect.Views.MainView({});
    this.currentView.render();
  }
});