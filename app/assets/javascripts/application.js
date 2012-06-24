//= require core
//= require jquery_ujs
//= require underscore
//= require_tree ./templates

$(function () {
  var $repos = $("#repos"),
      $winners = $("#winners");

  _.each(GP.repos, function (repo) {
    var rendered = JST["templates/repo"](repo);

    $repos.append(rendered);
  });

  _.each(GP.winners, function (repo) {
    var rendered = JST["templates/repo"](repo);

    $winners.append(rendered);
  });

  $repos.on("click", "button", function (event) {
    var $el = $(event.target).parent(),
        repoName = $el.find("span").first().text();

    $.ajax({
      type: "POST",

      url: "/votes",

      data: {
        vote: {
          repo_name: repoName
        }
      },

      dataType: "json",

      success: function (data, textStatus, jqXHR) {
        var rendered = JST["templates/repo"](data);

        $el.replaceWith(rendered);
      },

      error: function () {
        console.log("error", arguments);
      }
    });
  });

  $("#search").on("submit", function (event) {
    event.preventDefault();

    if ($repos.children().length !== 0 || $("#search-input").val().length === 0) {
      return;
    }

    // Nominate a new repo
    $.ajax({
      type: "POST",

      url: "/repos",

      data: {
        repo: {
          name: $("#search-input").val()
        }
      },

      dataType: "json",

      success: function (data, textStatus, jqXHR) {
        var rendered = JST["templates/repo"](data);

        $repos.prepend(rendered);
      },

      error: function () {
        console.log("error", arguments);
      }
    });
  });

  $("#search-input").on("keyup", function (event) {
    var query = $(event.target).val(),
        matchedRepos;

    // Find repos which match the query
    matchedRepos = _.filter(GP.repos, function (repo) {
      return repo.name.slice(0, query.length) === query;
    });

    // Clear the rendered repos
    $repos.empty();

    // Re-render matched repos
    _.each(matchedRepos, function (repo) {
      var rendered = JST["templates/repo"](repo);

      $repos.append(rendered);
    });
  });
});
