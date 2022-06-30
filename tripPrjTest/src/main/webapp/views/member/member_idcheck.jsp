<%@ page contentType="text/html; charset=UTF-8"%>
<%@page import="com.dao.MemberDao"%>

<%
	request.setCharacterEncoding("utf-8");

	String id = request.getParameter("memid");
	String pass = request.getParameter("mempass");
	System.out.println("id=" + id);
	System.out.println("pass=" + pass);
	
	MemberDao md = new MemberDao();
	
	int re = md.checkMemberId(id);
	
	out.println(re);
%>
