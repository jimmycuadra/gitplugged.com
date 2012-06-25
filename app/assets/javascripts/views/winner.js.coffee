class GP.Views.Winner extends Backbone.View
  tagName: "article"

  className: "winner span4"

  template: JST["winner"]

  render: ->
    @$el.html(@template(@model.toJSON()))
    this
