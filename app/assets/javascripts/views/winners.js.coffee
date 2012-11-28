class gp.WinnersView extends Backbone.View
  initialize: ->
    @setElement($("#winners"))

    @collection.bind("add", @add, this)
    @collection.bind("reset", @addAll, this)

  add: (repo) =>
    view = new gp.WinnerView(model: repo)
    @$el.append(view.render().el)

  addAll: ->
    @collection.each(@add)
