HueConnect.Views.MainView = Backbone.View.extend({

  el: '#content',

  template: _.template( $('#main-view-template').html() ),

  events: {
  },

  info_view: null,
  light_views: [],

  initialize: function() {
    var view = this;
    HueConnect.vent.on("information:recieved", function(hub_info) {
      view.info_view.render(hub_info);
      view.setupLightViews(hub_info['lights']);
    });
  },

  dispose: function() {
    HueConnect.vent.off("information:recieved");
    this.destroy();
  },

  render: function() {
    $(this.el).html(this.template({}));
    this.setupInfoView();
  },

  setupInfoView: function() {
    if (this.info_view) {
      this.info_view.dispose();
    }
    this.info_view = new HueConnect.Views.InfoView({});
    this.info_view.getInfo();
  },

  setupLightViews: function(lights) {
    if (this.light_views) {
      for (var i=0; i < this.light_views.length; i++) {
        this.light_views[i].dispose();
      }
      this.light_views = []  
    }
    $('#lights-view').html('');
    for (var lightIndex in lights) {
      var lightView = new HueConnect.Views.LightView();
      this.light_views.push(lightView);
      $('#lights-view').append(lightView.render(lights[lightIndex]));
    }
  }
});