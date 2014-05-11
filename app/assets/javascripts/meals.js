$(document).ready(function(){
  $(document).on('mouseenter', '.meal', function(){
    $(this).children().css('background-color', '#DDDDDD');
  });
  $(document).on('mouseleave', '.meal', function(){
    $(this).children().css('background-color', '');
  });
});

