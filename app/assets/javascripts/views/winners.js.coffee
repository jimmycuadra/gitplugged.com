class GP.Views.Winners extends Backbone.View
  initialize: ->
    @setElement($("#winners"))
    @collection.bind("add", @add, this)
    @collection.bind("reset", @render, this)

  add: (repo) =>
    view = new GP.Views.Winner(model: repo)
    @$el.append(view.render().el)

  render: ->
    @collection.each(@add)
