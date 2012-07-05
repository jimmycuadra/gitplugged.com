#= require jquery
#= require chai-jquery
#= require sinon
#= require sinon-chai
#= require_self
#= require core

window.JST = {}

window.SpecHelper =
  model:
    toJSON: ->
      name: "Foo"

  template: (data) ->
    "Hello, #{data.name}!"
