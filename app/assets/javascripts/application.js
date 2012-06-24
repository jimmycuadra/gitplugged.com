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
});
