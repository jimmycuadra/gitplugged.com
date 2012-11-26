class gp.Repo extends Backbone.Model
  points: ->
    parseInt(@get("vote_sum"))
