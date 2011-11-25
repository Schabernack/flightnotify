$(document).on("click", '#reset', ->
  $("#flight_flight_number").val("");
  $.post('remove_from_db', { flight_id: -> $("#flight_id").val()});
  $("#flight_details").children().detach();
  
) 


