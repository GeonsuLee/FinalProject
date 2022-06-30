<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="navbar navbar-expand-lg navbar-light fixed-top" data-scroll-header>
  <div class="container"><a class="navbar-brand me-3 me-xl-4" href="main"><i class="fi-map me-2">&ensp;My Seoul Trip</i></a>
<c:choose>
<c:when test="${empty sessionScope.id }">
    <button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button><a class="btn btn-sm text-primary d-none d-lg-block order-lg-3" href="#signin-modal" data-bs-toggle="modal"><i class="fi-user me-2"></i>로그인</a>
</c:when>
<c:when test="${!empty sessionScope.id || !empty member || !empty member.profile}">
	<button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
          <div class="dropdown d-none d-lg-block order-lg-3 my-n2 me-3"><a class="d-block py-2" href="myPage"><img class="rounded-circle" src="upload/1654162346515miro.jpg" width="40"></a>
            <div class="dropdown-menu dropdown-menu-end">
              <div class="d-flex align-items-start border-bottom px-3 py-1 mb-2" style="width: 16rem;"><img class="rounded-circle" src="upload/1654162346515miro.jpg" width="48"> <!-- member.profile -->
                <div class="ps-2">
                  <h6 class="fs-base mb-0">${sessionScope.id}</h6>
                  <div class="fs-xs py-2">${member.mail}</div>
                </div>
              </div>
              <a class="dropdown-item" href="myPage"><i class="fi-user opacity-60 me-2"></i>개인정보</a>
              <a class="dropdown-item" href="#"><i class="fi-home opacity-60 me-2"></i>예약내역</a>
              <a class="dropdown-item" href="#"><i class="fi-bookmark opacity-60 me-2"></i>북마크</a>
              <a class="dropdown-item" href="#"><i class="fi-star opacity-60 me-2"></i>리뷰</a>
              <a class="dropdown-item" href="#"><i class="fi-help opacity-60 me-2"></i>Q&A</a>
              <div class="dropdown-divider"></div><a class="dropdown-item" href="logout">로그아웃</a>
            </div>
          </div>
</c:when>
<c:when test="${!empty sessionScope.id && !empty member && empty member.profile}">
	<button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
          <div class="dropdown d-none d-lg-block order-lg-3 my-n2 me-3"><a class="d-block py-2" href="myPage"><img class="rounded-circle" src="img/avatars/13.png" width="40"></a>
            <div class="dropdown-menu dropdown-menu-end">
              <div class="d-flex align-items-start border-bottom px-3 py-1 mb-2" style="width: 16rem;"><img class="rounded-circle" src="img/avatars/13.png" width="48">
                <div class="ps-2">
                  <h6 class="fs-base mb-0">${sessionScope.id}</h6>
                  <div class="fs-xs py-2">${member.mail}</div>
                </div>
              </div>
              <a class="dropdown-item" href="myPage"><i class="fi-user opacity-60 me-2"></i>개인정보</a>
              <a class="dropdown-item" href="#"><i class="fi-home opacity-60 me-2"></i>예약내역</a>
              <a class="dropdown-item" href="#"><i class="fi-bookmark opacity-60 me-2"></i>북마크</a>
              <a class="dropdown-item" href="#"><i class="fi-star opacity-60 me-2"></i>리뷰</a>
              <a class="dropdown-item" href="#"><i class="fi-help opacity-60 me-2"></i>Q&A</a>
              <div class="dropdown-divider"></div><a class="dropdown-item" href="logout">로그아웃</a>
            </div>
          </div>
</c:when>
</c:choose>
	<c:if test="${sessionScope.id eq 'admin' && isMain != true && !empty placeList }"> 
    	<a class="btn btn-primary btn-sm ms-2 order-lg-3" href="placeWriteForm"><i class="fi-plus me-2"></i>글쓰기</a>
    </c:if>
	<c:if test="${sessionScope.id eq 'admin' && isMain != true && !empty foodList }"> 
    	<a class="btn btn-primary btn-sm ms-2 order-lg-3" href="foodWriteForm"><i class="fi-plus me-2"></i>글쓰기</a>
    </c:if>
    <c:if test="${sessionScope.id eq 'admin' && isMain != true && !empty roomList }"> 
    	<a class="btn btn-primary btn-sm ms-2 order-lg-3" href="roomWriteForm"><i class="fi-plus me-2"></i>글쓰기</a>
    </c:if>
	
    <div class="collapse navbar-collapse order-lg-2" id="navbarUserNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a href="placeList" class="nav-link">명소</a>
        </li>
        <li class="nav-item">
          <a href="foodList" class="nav-link">식당</a>
        </li>
        <li class="nav-item">
          <a href="roomList" class="nav-link">숙소</a>
        </li>
      </ul>
    </div>
  </div>
</header>