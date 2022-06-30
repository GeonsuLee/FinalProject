<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!doctype html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<title>명소 게시물 삭제</title>
	<link rel="stylesheet" type="text/css" href="./css/board.css" />
	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>

<body>
 <div id="boarddel_wrap">
  <h2 class="boarddel_title">명소 게시물 삭제</h2>
  <form method="post" action="placeDelete" 
  onsubmit="return del_check()">
  <input type="hidden" name="place_id" value="${place.place_id}" />
  <input type="hidden" name="page" value="${page}" />
   
   <div id="boarddel_menu">
    <input type="submit" value="삭제" class="input_button" />
    <input type="reset" value="취소" class="input_button"  />
   </div>
  </form>
 </div>
</body>
</html>
