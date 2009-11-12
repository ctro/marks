$(".mark").draggable({ 
  containment: 'parent',
  stop: function(event, ui) { $.post("/marks/position", { 'x':222, 'y':333 }) }
  
});

function show_new_mark_form(){
  $('#new_mark form').show('normal', function(){$('#mark_name').focus();} );
}

function hide_new_mark_form(){
  $('#new_mark form').hide('explode', 'slow');
}