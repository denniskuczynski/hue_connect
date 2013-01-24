HueConnect.Views.InfoView = Backbone.View.extend({

  el: '#info-view',

  template: _.template( $('#info-view-template').html() ),

  events: {
  },

  dispose: function() {
    this.destroy();
  },

  getInfo: function() {
    var view = this;
    xhr = $.getJSON('http://localhost:9292/hub_info');
    xhr.done(function(data) {
      HueConnect.vent.trigger("information:recieved", data);
    });
  },

  render: function(hub_info) {
    $(this.el).html(this.template({hub_info: hub_info}));
  }
});