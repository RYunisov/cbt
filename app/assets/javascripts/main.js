$(document).ready(function(){

	$(function() {
	    $('.bmethod').click(function(){
	    	val = $(this).val()
	    	$('.method_id').each(function(){
	    	  $(this).val(val);
	    	}); 
    	})
	});

    $(function() {
	    $('.bmethod').each(function(){
	    	if ( $(this).cheched == true ) {
		    	val = $(this).val()
		    	$('.method_id').each(function(){
		    	  $(this).val(val);
		    	}); 
		   	}
	    });
    });
});

function sub(id){
	$("#new_subscriber "+id).submit(function() {  
		console.log('SEND')
	    var valuesToSubmit = $(this).serialize();
	    $.ajax({
	    	type: 'POST',
	        url: '/subscribers',
	        //url: $(this).attr('/subscribers'), //sumbits it to the given url of the form
	        data: valuesToSubmit,
	        dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
	    }).success(function(json){ 
	    	container.html(data);
			hudMsg('success', 'Modify ports successfully.');
	    });
	    return false; // prevents normal behaviour
	});
};