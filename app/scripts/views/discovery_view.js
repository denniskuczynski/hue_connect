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
      console.log(data);
      HueConnect.mainRouter.navigate('/', {trigger: true});
    });
  }
});