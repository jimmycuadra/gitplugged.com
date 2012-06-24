#= require jquery_ujs
#= require underscore
#= require hamlcoffee
#= require_self
#= require_tree ./templates

window.GP = {}

jQuery ->
  $repos = $("#repos")
  $winners = $("#winners")
  $search = $("#search")
  $searchInput = $("#search-input")
  $help = $searchInput.find(".help-inline")

  _.each GP.repos, (repo) ->
    $repos.append(JST["repo"](repo))

  _.each GP.winners, (repo) ->
    $winners.append(JST["winner"](repo))

  $repos.on "click", "button", (event) ->
    $el = $(event.target).parent()
    repoName = $el.find("span").first().text()

    $.ajax
      type: "POST"
      url: "/votes"
      data:
        vote:
          repo_name: repoName
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        $el.replaceWith(JST["repo"](data))
      error: ->
        console.log(arguments)

  $search.on "submit", (event) ->
    event.preventDefault()

    return if $repos.children.length is not 0 or $searchInput.val().length is 0

    $.ajax
      type: "POST"
      url: "/repos"
      data:
        repo:
          name: $searchInput.val()
      dataType: "json"
      success: (data, textStatus, jqXHR) ->
        GP.repos.unshift(data)
        $searchInput.val("").trigger("search.reset")
      error: (jqXHR, textStatus, errorThrown) ->
        data = null

        try
          data = JSON.parse(jqXHR.responseText)
        catch error
          data = { message: "An unknown error occurred." }

        $help.text(data.message).addClass("error")

  $searchInput.on "keyup search.reset", (event) ->
    query = $(event.target).val()

    $help.removeClass("error")

    if query.length is 0
      $help.text("")
    else if $repos.children().length is 0
      $help.text("Hit return to nominate the repository #{query}!")
    else
      $help.text('Add your vote to a repository by clicking an "Endorse" button!')

    matchedRepos = _.filter GP.repos, (repo) ->
      repo.name.slice(0, query.length) is query

    $repos.empty()

    _.each matchedRepos, (repo) ->
      $repos.append(JST["repo"](repo))
