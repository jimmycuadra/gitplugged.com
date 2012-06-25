class GP.Models.Repo extends Backbone.Model
  points: ->
    parseInt(@get("vote_sum"))

  loggedIn: ->
    GP.app.loggedIn
