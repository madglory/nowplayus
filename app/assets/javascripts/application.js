//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery-ui
//= require jquery_nested_form
//= require select2
//= require game_selector
//= require_self
$(document).foundation();
$(document).on('nested:fieldRemoved', function (event) {
  $('[required]', event.field).removeAttr('required');
});