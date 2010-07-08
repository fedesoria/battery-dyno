// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var dynos = 1;

function opacity_minus() {
  if (dynos > 1) {
    $('.minus_button').css('opacity', 1);
  } else {
     $('.minus_button').css('opacity', 0.6);
  };
};


$(document).ready(function() {
  opacity_minus();
  
  $('.add_button').click( function() {
    var temp_dyno_count = parseInt($('.dynos').html());
    $('.dynos').html(temp_dyno_count + 1);
    dynos += 1;
    opacity_minus();
    return false;
  });
  
  $('.minus_button').click( function() {
    if (dynos > 1) {
      var temp_dyno_count = parseInt($('.dynos').html());
      $('.dynos').html(temp_dyno_count - 1);
      dynos -= 1;
    };
    opacity_minus();
    return false;
  });
});
