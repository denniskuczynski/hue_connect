HueConnect.Views.InfoView = Backbone.View.extend({

  el: '#content',

  template: _.template( $('#info-view-template').html() ),

  events: {
  },

  hub_info: {},

  initialize: function() {
    var view = this;
    xhr = $.getJSON('http://localhost:9292/hub_info');
    xhr.done(function(data) {
      view.hub_info = data;
      view.render();
    });
  },

  render: function() {
    $(this.el).html(this.template({hub_info: JSON.stringify(this.hub_info)}));
  }
});