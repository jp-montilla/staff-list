$(document).ready(function(){
	$('#question_answer_type').on('change', function() {
		if (this.value == 'Choice') {
			// $("#choices-tbl").html("<%= j render 'choices/collection' %>");
			// $(".main-content__body").hide();
			// $('#abcd').prop('disabled', true);

	  	}
	  	else{
	  		// $('#abcd').prop('disabled', false);
	  	}
	});
});
