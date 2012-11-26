class gp.ReposView extends Backbone.View
  initialize: ->
    @setElement($("#repos"))
    @collection.bind("add", @add, this)
    @collection.bind("reset", @render, this)

  add: (repo) =>
    view = new gp.RepoView(model: repo)
    @$el.append(view.render().el)

  render: ->
    @collection.each(@add)
