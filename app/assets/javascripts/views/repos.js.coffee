class GP.Views.Repos extends Backbone.View
  initialize: ->
    @setElement($("#repos"))
    @collection.bind("add", @add, this)
    @collection.bind("reset", @render, this)

  add: (repo) =>
    view = new GP.Views.Repo(model: repo)
    @$el.append(view.render().el)

  render: ->
    @collection.each(@add)
