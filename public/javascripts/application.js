// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var dynos = 1;
$(document).ready(function() {
  $('.add_button').click( function() {
    var temp_dyno_count = parseInt($('.dynos').html());
    $('.dynos').html(temp_dyno_count + 1);
    dynos += 1;
    return false;
  });
});
