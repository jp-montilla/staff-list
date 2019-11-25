$(document).ready(function(){
  $("#serial_number").hide()
  $("#material_material_type").change(function(){
    var item=$(this);
    if (item.val() == 'License') {
      $("#serial_number").show()
    }
    else{
      $("#serial_number").hide()
    }
  });
});
