function show_new_mark_form(){
  $('#new_mark form').show('normal', function(){$('#mark_name').focus();} );
}

function hide_new_mark_form(){
  $('#new_mark form').hide('explode', 'slow');
}