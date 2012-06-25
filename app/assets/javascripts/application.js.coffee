#= require jquery_ujs
#= require underscore
#= require backbone
#= require hamlcoffee
#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./views

window.GP =
  Models: {}
  Collections: {}
  Views: {}
  Application: class Application
    constructor: (serverData) ->
      @repos = new GP.Collections.Repos
      @reposView = new GP.Views.Repos(collection: @repos)
      @repos.reset(serverData.repos)

      @winners = new GP.Collections.Repos
      @winnersView = new GP.Views.Winners(collection: @winners)
      @winners.reset(serverData.winners)

      @formView = new GP.Views.Form
