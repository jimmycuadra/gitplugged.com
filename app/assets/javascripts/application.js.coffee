#= require core
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

class gp.Application
  constructor: (serverData) ->
    @repos = new gp.Repos
    @reposView = new gp.ReposView(collection: @repos)

    @winners = new gp.Winners
    @winnersView = new gp.WinnersView(collection: @winners)

    @formView = new gp.FormView(collection: @repos)

    @repos.fetch()
    @winners.fetch()

$ ->
  gp.app = new gp.Application
