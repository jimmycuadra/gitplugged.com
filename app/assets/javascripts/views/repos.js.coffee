class gp.ReposView extends Backbone.View
  initialize: ->
    @setElement($("#repos"))

    @collection.bind("add", @add, this)
    @collection.bind("reset", @addAll, this)

  add: (repo) =>
    view = new gp.RepoView(model: repo)
    @$el.append(view.render().el)

  addAll: ->
    @collection.each(@add)
