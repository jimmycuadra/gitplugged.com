class GP.Views.Repo extends Backbone.View
  tagName: "article"

  className: "repo clearfix"

  template: JST["repo"]

  events:
    "click button": "endorse"

  render: ->
    @$el.html(@template(@model.toJSON()))
    this

  endorse: (event) ->
