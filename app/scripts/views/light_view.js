HueConnect.Views.LightView = Backbone.View.extend({

  tagName: 'div',
  className: 'light-view',

  template: _.template( $('#light-view-template').html() ),

  events: {
  },

  hub_info: {},

  initialize: function() {
  },

  dispose: function() {
    this.destroy();
  },

  render: function(light) {
    this.$el.append(this.template({light: light}));
    return this.$el;
  }
});