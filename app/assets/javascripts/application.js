// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3


//= require_tree .

//= require popper
//= require bootstrap-sprockets
//= require chartkick
//= require Chart.bundle


$(document).ready(function(){
  $(".material_profile").hide();
  $("#cancel-btn").hide()
	$('#view_type_report').click(function(){
		$('#type_report').show()
		$('#status_report').hide()
	});
	$('#view_status_report').click(function(){
		$('#type_report').hide()
		$('#status_report').show()
	});


  $("#btn_donut_status").click(function(){
    $("#donut_status").show()
    $("#line_status").hide()
    $("#bar_status").hide()
    $("#area_status").hide()
  });
  $("#btn_line_status").click(function(){
    $("#donut_status").hide()
    $("#line_status").show()
    $("#bar_status").hide()
    $("#area_status").hide()
  });
  $("#btn_bar_status").click(function(){
    $("#donut_status").hide()
    $("#line_status").hide()
    $("#bar_status").show()
    $("#area_status").hide()
  });
  $("#btn_area_status").click(function(){
    $("#donut_status").hide()
    $("#line_status").hide()
    $("#bar_status").hide()
    $("#area_status").show()
  });


  $("#btn_donut_type").click(function(){
    $("#donut_type").show()
    $("#line_type").hide()
    $("#bar_type").hide()
    $("#area_type").hide()
  });
  $("#btn_line_type").click(function(){
    $("#donut_type").hide()
    $("#line_type").show()
    $("#bar_type").hide()
    $("#area_type").hide()
  });
  $("#btn_bar_type").click(function(){
    $("#donut_type").hide()
    $("#line_type").hide()
    $("#bar_type").show()
    $("#area_type").hide()
  });
  $("#btn_area_type").click(function(){
    $("#donut_type").hide()
    $("#line_type").hide()
    $("#bar_type").hide()
    $("#area_type").show()
  });

  $("#cancel-btn").click(function(){
    $("#cancel-btn").hide()
    $("#questions-tbl").removeClass("col-8");
    $("#questions-tbl").addClass("col-12");
    $("#form-show").removeClass("col-4");
    $("#form-show").hide()
  });

  $("#button_question").click(function(){
    $("#button_material").removeClass("active_button");
    $("#button_question").addClass("active_button");
    $(".question_profile").show();
    $(".material_profile").hide();

    $("#questions-tbl").removeClass("col-8");
    $("#questions-tbl").addClass("col-12");
    $("#form-show").removeClass("col-4");
    $("#form-show").hide()
    $("#cancel-btn").hide()

  });
  $("#button_material").click(function(){
    $("#button_question").removeClass("active_button");
    $("#button_material").addClass("active_button");
    $(".material_profile").show();
    $(".question_profile").hide();

    $("#questions-tbl").removeClass("col-8");
    $("#questions-tbl").addClass("col-12");
    $("#form-show").removeClass("col-4");
    $("#form-show").hide()
    $("#cancel-btn").hide()

  });
  

});
