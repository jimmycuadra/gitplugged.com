class gp.WinnersView extends Backbone.View
  initialize: ->
    @setElement($("#winners"))
    @collection.bind("add", @add, this)
    @collection.bind("reset", @render, this)

  add: (repo) =>
    view = new gp.WinnerView(model: repo)
    @$el.append(view.render().el)

  render: ->
    @collection.each(@add)
