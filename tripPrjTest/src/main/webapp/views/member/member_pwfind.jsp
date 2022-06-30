<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:if test="${result == 1 }">
	<script>
		alert("비밀번호가 발송되었습니다. 메일함을 확인해주세요.");
		history.go(-1);
	</script>
</c:if>