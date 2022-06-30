<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
  
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원가입폼</title>
<!-- <script src="/springmember/js/jquery.js"></script> -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<!-- <script src="./js/member.js"></script> -->
<script type="text/javascript" src="./js/member.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
//우편번호, 주소 Daum API
function openDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {				
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
			// 우편번호와 주소 정보를 해당 필드에 넣고, 커서를 상세주소 필드로 이동한다.
			document.getElementById('post').value = data.zonecode;
			document.getElementById('addr1').value = data.address;				
		}
	}).open();
}
</script>

</head>
<body>
 <div id="joinwrap">
  <h2 class="jointitle">회원가입</h2>
  <form name="f" method="post" action="joinOk"
  		onsubmit="return check()" enctype="multipart/form-data">
   <!-- 이진파일을 업로드 할려면 enctype 속성을 지정 -->
   <table id="joint">
    <tr>
     <th>회원아이디</th>
     <td>
      <input name="id" id="id" size="14" class="box" />
      <input type="button" value="중복확인" onclick="idcheck()" />
      <div id="idcheck"></div>
     </td>
    </tr>
    
    <tr>
     <th>회원비번</th>
     <td>
      <input type="password" name="pw" id="pw" size="14"
      class="box" />
     </td>
    </tr>
    
    <tr>
     <th>회원비번확인</th>
     <td>
      <input type="password" name="pw2" id="pw2" size="14"
      class="box" />
     </td>
    </tr>
    
    <tr>
     <th>회원이름</th>
     <td>
      <input name="name" id="name" size="14" class="box" />
     </td>
    </tr>
    
    <tr>
     <th>우편번호</th>
     <td>
      <input name="post" id="post" size="5" class="box"
      		readonly onclick="postSearch()" />
      <input type="button" value="우편번호검색" class="button"
      		onclick="openDaumPostcode()" />
     </td>
    </tr>
    
    <tr>
     <th>주소</th>
     <td>
      <input name="addr1" id="addr1" size="50" class="box"
      readonly onclick="postSearch()" />
     </td>
    </tr>
    
    <tr>
     <th>나머지 주소</th>
     <td>
      <input name="addr2" id="addr2" size="37" class="box" />
     </td>
    </tr>
    
    <tr>
     <th>전화번호</th>
     <td>         
      	 <input name="tel" id="tel" size="20" maxlength="20" class="box" value="${tel}"/>
     </td>
    </tr>
    
    <tr>
     <th>전자우편</th>
     <td>
      <input name="mail" id="mail" size="10" class="box" />
      <input type="button" value="이메일 인증" class="button"
      	onclick="send()" />
      <div id="send"></div>
     </td>
    </tr>
    
    <tr>
     <th>프로필사진</th>
     <td>
      <input type="file" name="profile" />
     </td>
    </tr>
   </table>
   
   <div id="joinmenu">
    <input type="submit" value="회원가입" class="button" />
    <input type="reset" value="취소" class="button" 
    onclick="$('#id').focus();" />
   </div>
  </form>
 </div>
</body>
</html>
