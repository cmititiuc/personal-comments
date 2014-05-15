$(document).ready(function(){
  $(document).on('click', '#scheduled_event_form_revealer', function(){
    $('#scheduled_event_form_container').toggle();
  });
  $(document).on('click', '.fake_link', function(){ return false; });
});

