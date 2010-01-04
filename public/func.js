function show_new_mark_form(){
  $('#new_mark form').show('normal', function(){$('#mark_name').focus();} );
}

function hide_new_mark_form(){
  $('#new_mark form').hide('normal');
}

function show_edit_mark_form(id){
  $('#edit_mark_' + id + ' form').show('normal');
}

function hide_edit_mark_form(id){
  $('#edit_mark_' + id + ' form').hide('normal');
}