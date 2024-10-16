$(function(){
  $("#menu-toggle").click(function(e) {
      e.preventDefault();
      $("#wrapper").toggleClass("toggled");
  });
});

jQuery(document).ready(function($) {
  var alterClass = function() {
    var ww = document.body.clientWidth;
    if (ww <= 991) {
      $('#wrapper').removeClass('toggled');
    } else {
      $('#wrapper').addClass('toggled');
    };
  };
  $(window).resize(function(){
    alterClass();
  });
  //Fire it when the page first loads:
  alterClass();
});


$(document).ready(cHeight);
$(window).resize(cHeight);
function cHeight(){  
    var docHeight = $(window).outerHeight();
    var headerHeight = $("header").outerHeight();
    var sidebarWidth = $("#sidebar-wrapper").outerWidth();
    var sidebarHeight = docHeight - headerHeight + 'px';
    //alert(sidebarWidth);
    $('.sidebar-brand').css('min-width', sidebarWidth - '15' + 'px');
    $('#sidebar-wrapper').css('height', sidebarHeight);
}