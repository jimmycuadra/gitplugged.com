#= require core
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

class gp.Application
  constructor: (serverData) ->
    @repos = new gp.Repos
    @reposView = new gp.ReposView(collection: @repos)
    @repos.reset(serverData.repos)

    @winners = new gp.Repos
    @winnersView = new gp.WinnersView(collection: @winners)
    @winners.reset(serverData.winners)

    @formView = new gp.FormView
