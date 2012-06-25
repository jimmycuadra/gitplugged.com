class GP.Views.Form extends Backbone.View
  events:
    "submit": "nominate"
    "keyup input": "filter"

  initialize: ->
    @$el = $("#search")
    @$input = @$el.find("input")
    @$help = @$el.find(".help-inline")

  nominate: (event) ->
    event.preventDefault()

  filter: (event) ->
    event.preventDefault()
