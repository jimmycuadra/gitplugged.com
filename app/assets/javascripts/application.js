//= require core
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
});
