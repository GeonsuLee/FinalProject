<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="webjars/jquery/dist/jquery.min.js"></script>


<c:if test="${result == 1 }">
	<script type="text/javascript">
		alert("파일은 10MB까지 업로드 가능합니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 2 }">
	<script type="text/javascript">
		alert("첨부파일은 jpg, gif, png파일만 업로드 가능합니다.");
		history.go(-1);
	</script>
</c:if>