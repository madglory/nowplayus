$(document).ready(function(){
  $("#event_game_id").select2({
    placeholder: "Search for a game",
    minimumInputLength: 3,
    ajax: {
      url: "/games.json",
      dataType: 'json',
      quietMillis: 100,
      data: function (term, page) {
        return {
          q: term, // search term
          page_limit: 10,
          page: page
        };
      },
      results: function (data, page) {
        var more = (page * 10) < data.total;
        return {results: data.games, more: more};
      }
    },
    formatResult: gameFormatResult,
    formatSelection: gameFormatSelection,
    dropdownCssClass: "bigdrop",
    escapeMarkup: function (m) { return m; }
  });

  function gameFormatResult(game) {
    var markup = "<table class='game-result'><tr>";
    if(game.icon_url !== null){
      markup += "<td class='game-image'><img src='" + game.icon_url + "'/></td>";
    }
    markup += "<td class='game-info'><h3 class='game-name'>" + game.name + "</h3>";
    markup += "<p class='game-synopsis'>" + game.deck + "</p>";
    markup += "</td></tr></table>";
    return markup;
  }

  function gameFormatSelection(game) {
    return game.name;
  }
});