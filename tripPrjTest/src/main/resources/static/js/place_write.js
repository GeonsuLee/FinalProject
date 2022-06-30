$(document).ready(function(){ 
	$("form").submit(function(){
		
		var $placePhotos = $("input[type='file']");
		if(parseInt($placePhotos.get(0).files.length) <= 0){
			alert("사진 첨부는 필수입니다. (최대 5장)");
			return false;
		}
		
		var $placePhotos = $("input[type='file']");
		if(parseInt($placePhotos.get(0).files.length) > 5){
			alert("최대 5장의 사진만 올릴 수 있습니다.");
			return false;
		}
		
		
	});
});