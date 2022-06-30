$(document).ready(function() {
	$('#city').change(function() {
		var sel  = $(this).val();
		if (sel == '마포구') {
			$('#district').html(
               '<option value="연남동">연남동</option>'+
               '<option value="합정동">합정동</option>'+
               '<option value="상암동">상암동</option>'+
               '<option value="망원동">망원동</option>'+
               '<option value="상수동">상수동</option>'+
               '<option value="서교동">서교동</option>'+
               '<option value="동교동">동교동</option>');
		}
		if (sel == '성동구') {
			$('#district').html(
               '<option value="성수1가">성수1가</option>'+
               '<option value="성수2가">성수2가</option>'+
               '<option value="행당동">행당동</option>'+
               '<option value="사근동">사근동</option>');
		} 
		if (sel == '용산구') {
			$('#district').html(             
               '<option value="이태원">이태원</option>'+
               '<option value="용산동">용산동</option>'+
               '<option value="효창동">효창동</option>'+
               '<option value="청파동">청파동</option>'+
               '<option value="한남동">한남동</option>');
		}  
		if (sel == '강남구') {
			$('#district').html(             
               '<option value="압구정">압구정</option>'+
               '<option value="청담동">청담동</option>'+
               '<option value="삼성동">삼성동</option>'+
               '<option value="신사동">신사동</option>'+
               '<option value="삼성동">삼성동</option>'+
               '<option value="논현동">논현동</option>');
		} 
		if (sel == '영등포구') {
			$('#district').html(             
               '<option value="여의도">여의도</option>'+
               '<option value="문래동">문래동</option>'+
               '<option value="양화동">영화동</option>'+
               '<option value="양평동">양평동</option>'+
               '<option value="영등포동">영등포동</option>');
		} 
		if (sel == '종로구') {
			$('#district').html(             
               '<option value="인사동">인사동</option>'+
               '<option value="계동">계동</option>'+
               '<option value="동숭동">동숭동</option>'+
               '<option value="평창동">평창동</option>'+
               '<option value="삼청동">삼청동</option>');
		} 
		if (sel == '서초구') {
			$('#district').html(             
               '<option value="반포동">반포동</option>'+
               '<option value="양재동">양재동</option>'+
               '<option value="잠원동">잠원동</option>'+
               '<option value="서초동">서초동</option>'+
               '<option value="내곡동">내곡동</option>');
		} 
		if (sel == '송파구') {
			$('#district').html(             
               '<option value="잠실동">잠실동</option>'+
               '<option value="방이동">방이동</option>'+
               '<option value="문정동">문정동</option>'+
               '<option value="가락동">가락동</option>'+
               '<option value="신천동">신천동</option>');
		} 
		if (sel == '중구') {
			$('#district').html(             
               '<option value="을지로">을지로</option>'+
               '<option value="충무로">충무로</option>'+
               '<option value="남대문로">남대문로</option>'+
               '<option value="태평로">태평로</option>'+
               '<option value="명동">명동</option>'+
               '<option value="정동">정동</option>'+
               '<option value="신당동">신당동</option>'+
               '<option value="회현동">회현동</option>');
		} 
	});
});	