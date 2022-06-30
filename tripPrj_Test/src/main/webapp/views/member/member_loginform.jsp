<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script>
 function check(){
	 if($.trim($("#signup-id").val())==""){
		 alert("로그인 아이디를 입력하세요!");
		 $("#signup-id").val("").focus();
		 return false;
	 }
	 if($.trim($("#signup-password").val())==""){
		 alert("비밀번호를 입력하세요!");
		 $("#signup-password").val("").focus();
		 return false;
	 }
 }
 
 /*비번찾기 공지창*/
 function pwFind(){
	 window.open("pwFind","비번찾기","width=450,height=500");
	 //자바 스크립트에서 window객체의 open("공지창경로와 파일명","공지창이름","공지창속성")
	 //메서드로 새로운 공지창을 만듬.폭이 400,높이가 400인 새로운 공지창을 만듬.단위는 픽셀
 }
</script>
</head>
<body>
 <div id="loginwrap">
  <h2 class="logintitle">로그인</h2>
  <form method="post" action="joinOk"
  		onsubmit="return check()">
   <table id="logint">
    <tr>
     <th>아이디</th>
     <td>
      <input name="id" id="id" size="20" class="box" />
     </td>
    </tr>
    
    <tr>
     <th>비밀번호</th>
     <td>
     <input type="password" name="pw" id="pw" size="20" class="box"/>
     </td>
    </tr>
   </table>
    <div id="loginmenu">
    <input type="submit" value="로그인" class="button" />
    <input type="reset" value="취소" class="button"
    		onclick="$('#signup-id').focus();" />
    <input type="button" value="회원가입" class="button"
    		onclick="location='signup-modal'" />
    <input type="button" value="비번찾기" class="button"
    		onclick="pwFind()" />
    </div>
  </form>
 </div>
</body>
</html>