$(document).ready(function(){ 
	$("form").submit(function(){
		
		if($("#food_cost").val() < 0){
			alert("음수는 입력할 수 없습니다.");
			$("#food_cost").val("").focus();
			return false;
		}
		
		if(isNaN($("#food_cost").val())){
			alert("숫자만 입력하세요.");
			$("#food_cost").val("").focus();
			return false;
		}
		
		var $foodPhotos = $("input[type='file']");
		if(parseInt($foodPhotos.get(0).files.length) <= 0){
			alert("사진 첨부는 필수입니다. (최대 5장)");
			return false;
		}
		
		var $foodPhotos = $("input[type='file']");
		if(parseInt($foodPhotos.get(0).files.length) > 5){
			alert("최대 5장의 사진만 올릴 수 있습니다.");
			return false;
		}
		
		
	});
});