class exports.MainRouter extends Backbone.Router
  routes :
    "": "home"

  home: ->
    app.views.home.render()
