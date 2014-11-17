var original_text = {};

$(document).on('click', '.comment', function(){
  $this = $(this);
  $.ajax({
    url: 'comments/get_comment',
    type: 'GET',
    data: { id : $this.attr('data-id'), height : $this.height() },
    success: function( data, textStatus, jqXHR ){
      original_text[$this.attr('data-id')] = $this.html();
      var cancel_markup = '<div class="cancel"><a href="#">Cancel</a></div>';
      $this.html(data).prepend(cancel_markup).removeClass('comment');
    }
  })
});

$(document).on('ajax:beforeSend', '.edit', function(e, data){
  $(this).attr('data-height', $(this).parent().siblings('.comment').height());
});

$(document).on('click', '#new_comment #comment_comment', function(){ 
  $(document).off('click', '#comment_comment');
});

$(document).on('click', '.cancel', function(){
  var $parent = $(this).parent();
  $parent.addClass('comment').html(original_text[$parent.attr('data-id')]);
  return false;
});

$(document).on('click', '.remove_notice', function(){ $(this).parent().remove(); });

$(document).on('ajax:success', '#new_comment', function( e, data ){
  $('#new_comment #comment_comment').val('');
  var $new_first_row = $('#list tbody tr:nth-child(1)');
  var $old_first_row = $('#list tbody tr:nth-child(2)');
  if ($old_first_row.children('td:first').text().trim() == $new_first_row.children('td:first').text().trim())
    $old_first_row.children('td:first').text('');
});

$(document).on('ajax:success', '.destroy', function(e, data){
  $('#notices').append('<div class="notice">' + data + '<div class="remove_notice">X</div></div>');
  $('.notice').last().delay(5000).fadeOut('slow', function(){ $(this).remove(); });
  var $row = $(this).closest('tr')
  var $out_row_date = $row.children('td:first');
  if ($out_row_date.text().trim().length > 0) {
    var $next_row_date = $row.next().children('td:first');
    if ($next_row_date.text().trim().length == 0)
      $next_row_date.text($out_row_date.text());
  }
  $(this).closest('tr').remove();
});

