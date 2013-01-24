HueConnect.Views.DiscoveryView = Backbone.View.extend({

  el: '#content',

  template: _.template( $('#discovery-view-template').html() ),

  events: {
    "click #discover-btn": "discover"
  },

  initialize: function() {
  },

  render: function() {
    $(this.el).html(this.template({}));
  },

  discover: function(router) {
    var view = this;
    xhr = $.post('http://localhost:9292/discover');
    xhr.done(function(data) {
      if (data.hub_ip == undefined || data.hub_ip == null ||
          data.username == undefined || data.username == null) {
        HueConnect.vent.trigger("configuration:invalid", data);
      } else {
        HueConnect.vent.trigger("configuration:valid", data);
      }
    });
  }
});