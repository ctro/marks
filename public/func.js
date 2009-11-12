
function make_draggable(mark_id){
  var db_id = mark_id.substring(5);
  var html_id = "#"+mark_id;
  
  $(html_id).draggable({ 
    containment: 'parent',
    stop: function(event, ui) { $.post("/marks/"+db_id+"/pos", { 'x':ui.position['left'], 'y':ui.position['top'] }) }
  });  
}

function show_new_mark_form(){
  $('#new_mark form').show('normal', function(){$('#mark_name').focus();} );
}

function hide_new_mark_form(){
  $('#new_mark form').hide('explode', 'slow');
}