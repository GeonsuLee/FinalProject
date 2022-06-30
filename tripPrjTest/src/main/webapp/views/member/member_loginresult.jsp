<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<c:if test="${result == 1}">
	<script>
		alert("등록되지 않은 회원입니다.");
		history.go(-1);
	</script>
</c:if>

<c:if test="${result == 2}">
	<script>
		alert("회원 정보가 일치하지 않습니다.");
		history.go(-1);
	</script>
</c:if>
