//	var chkArr = new Array();
//	$.('input:checkbox[name=roomtype]:checked').each.(function() {
//		chkArr.push(this.value);
//	});

//$(document).ready(function() {
//	$('#roomQuery').load('roomList');
//	var form = $('form#roomFilter')

//	$('form').change(function(f) {
//		f.preventDefault();
		
//		var formData = $(form).serialize();
//		console.log(formData);

//		$.ajax({
//			type : 'post',
//			url : "roomFilter",
//			data : formData,
//			success : function(data){
//				$('#roomQuery').html(data);
//			}
//		});
//	});
//});	

//function roomFilter(){
//	$('#roomForm').click(function() {
//		alert($('#roomForm').serialize());
//		event.preventDefault();
//		var formData = $('#roomForm').serialize();
//		$ajax({
//			url : 'roomFilter',
//			type : 'post',
//			data : $('#roomForm').serialize(),
//			success : function(result) {
			
//			}
//		});
//	});
//};

//$('#repInsert').click(function() {
//	var frmData = $('form').serialize();		  
//	$.post('${path}/sInsert', frmData, function(data) {
//		$('#slist').html(data);
//		frm.replytext.value = '';
//	});
//});

//$( "form" ).click(function( event ) {
//	alert( $( this ).serializeArray() );
//	event.preventDefault();
//});