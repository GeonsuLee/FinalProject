<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.dao.MemberDao"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Main Page</title>
<!-- SEO Meta Tags-->
<meta name="description" content="Finder - Directory &amp; Listings Bootstrap Template">
<meta name="keywords" content="bootstrap, business, directory, listings, e-commerce, car dealer, city guide, real estate, job board, user account, multipurpose, ui kit, html5, css3, javascript, gallery, slider, touch">
<meta name="author" content="Createx Studio">
<!-- Viewport-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Favicon and Touch Icons-->
<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png">
<link rel="manifest" href="site.webmanifest">
<link rel="mask-icon" color="#5bbad5" href="safari-pinned-tab.svg">
<meta name="msapplication-TileColor" content="#766df4">
<meta name="theme-color" content="#ffffff">
<!-- Page loading styles-->
<style>
.page-loading {
	position: fixed;
	top: 0;
	right: 0;
	bottom: 0;
	left: 0;
	width: 100%;
	height: 100%;
	-webkit-transition: all .4s .2s ease-in-out;
	transition: all .4s .2s ease-in-out;
	background-color: #fff;
	opacity: 0;
	visibility: hidden;
	z-index: 9999;
}

.page-loading.active {
	opacity: 1;
	visibility: visible;
}

.page-loading-inner {
	position: absolute;
	top: 50%;
	left: 0;
	width: 100%;
	text-align: center;
	-webkit-transform: translateY(-50%);
	transform: translateY(-50%);
	-webkit-transition: opacity .2s ease-in-out;
	transition: opacity .2s ease-in-out;
	opacity: 0;
}

.page-loading.active>.page-loading-inner {
	opacity: 1;
}

.page-loading-inner>span {
	display: block;
	font-size: 1rem;
	font-weight: normal;
	color: #666276;;
}

.page-spinner {
	display: inline-block;
	width: 2.75rem;
	height: 2.75rem;
	margin-bottom: .75rem;
	vertical-align: text-bottom;
	border: .15em solid #bbb7c5;
	border-right-color: transparent;
	border-radius: 50%;
	-webkit-animation: spinner .75s linear infinite;
	animation: spinner .75s linear infinite;
}

@
-webkit-keyframes spinner { 100% {
	-webkit-transform: rotate(360deg);
	transform: rotate(360deg);
}

}
@
keyframes spinner { 100% {
	-webkit-transform: rotate(360deg);
	transform: rotate(360deg);
}
}
</style>
<!-- Page loading scripts-->
<script>
	(function() {
		window.onload = function() {
			var preloader = document.querySelector('.page-loading');
			preloader.classList.remove('active');
			setTimeout(function() {
				preloader.remove();
			}, 2000);
		};
	})();
</script>
<!-- Vendor Styles-->
<link rel="stylesheet" media="screen"
	href="vendor/simplebar/dist/simplebar.min.css" />
<link rel="stylesheet" media="screen"
	href="vendor/tiny-slider/dist/tiny-slider.css" />
<link rel="stylesheet" media="screen"
	href="vendor/flatpickr/dist/flatpickr.min.css" />
<!-- Main Theme Styles + Bootstrap-->
<link rel="stylesheet" media="screen" href="css/theme.min.css">
<script src="webjars/jquery/dist/jquery.min.js"></script>
<!-- 회원가입 폼(우편번호) -->
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
	function openDaumPostcode() {
		new daum.Postcode({
			oncomplete : function(data) {
				document.getElementById('signup-post').value = data.zonecode;
				document.getElementById('signup-address').value = data.address;
			}
		}).open();
	}
</script>
<!-- 로그인 인증  -->
<script>
	function checks() {
		if ($.trim($("#signin-email").val()) == "") {
			alert("로그인 아이디를 입력하세요!");
			$("#signin-email").val("").focus();
			return false;
		}
		if ($.trim($("#signin-password").val()) == "") {
			alert("비밀번호를 입력하세요!");
			$("#signin-password").val("").focus();
			return false;
		}
	}
	/*비번찾기 공지창*/
	function pwFind() {
		window.open("pwFind", "비번찾기", "width=450, height=500");
		//자바 스크립트에서 window객체의 open("공지창경로와 파일명","공지창이름","공지창속성")
		//메서드로 새로운 공지창을 만듬.폭이 400,높이가 400인 새로운 공지창을 만듬.단위는 픽셀
	}
</script>
<!-- 비번찾기 폼 -->
<script>
 function pwFindCheck(){
	 if($.trim($("#id").val())==""){
		 alert("아이디를 입력하세요!");
		 $("#id").val("").focus();
		 return false;
	 }
	 if($.trim($("#name").val())==""){
		 alert("회원이름을 입력하세요!");
		 $("#name").val("").focus();
		 return false;
	 }
 }
</script>
</head>
<!-- Body-->
<body>
	<!-- Page loading spinner-->
	<div class="page-loading active">
		<div class="page-loading-inner">
			<div class="page-spinner"></div>
			<span>Loading...</span>
		</div>
	</div>
	<main class="page-wrapper">
		<!-- Sign In Modal-->
		<div class="modal fade" id="signin-modal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered p-2 my-0 mx-auto" style="max-width: 450px;">
				<div class="modal-content">
					<div class="modal-body px-0 py-2 py-sm-0">
						<button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal"></button>
						    <div class="row mx-2 align-items-center">
							<div class="col-md-12 px-5 pt-5 pb-5 px-sm-8 pb-sm-8 pt-md-8">
								<a class="btn btn-outline-info rounded-pill w-100 mb-3" href="#">
								<i class="fi-google fs-lg me-1"></i>구글로 로그인하기</a>
								<a class="btn btn-outline-info rounded-pill w-100 mb-3" href="#">
								<i class="fi-facebook fs-lg me-1"></i>페이스북으로 로그인하기</a>
								<div class="d-flex align-items-center py-3 mb-3">
									<hr class="w-100">
									<div class="px-3">Or</div>
									<hr class="w-100">
								</div>
								 <div id="loginwrap">
								<form class="needs-validation" novalidate method="post" action="loginOk" onsubmit="return checks()">
									<table id="logint">
									<div class="mb-4">
										<label class="form-label mb-2" for="signin-email">아이디</label>
										<input class="form-control" type="text" id="signin-email" name="id" size="20" placeholder="아이디를 입력하세요" required>
									</div>
									<div class="mb-4">
										<div class="d-flex align-items-center justify-content-between mb-2">
										<label class="form-label mb-0" for="signin-password">비밀번호</label>
										<a class="fs-sm" href="pwFind">비밀번호를 잊으셨나요?</a>
										</div>
										<div class="mb-4">
											<div class="password-toggle">
												<input class="form-control" type="password" id="signin-password"  name="pw" size="20" placeholder="비밀번호를 입력하세요" required>
												<label class="password-toggle-btn" aria-label="Show/hide password"> 
												<input class="password-toggle-check" type="checkbox">
												<span class="password-toggle-indicator"></span>
												</label>
											</div>
										</div>      
										<div class="form-check mb-4">
											<input class="form-check-input" type="checkbox" id="agree-to-terms"> 
												<label class="form-check-label" for="agree-to-terms">로그인 유지</label>
										</div>
									</div>
									<div id="loginmenu">
									<button class="btn btn-primary btn-lg rounded-pill w-100" type="submit">로그인</button>
									<div class="mt-4 mt-sm-5"> 아직 회원가입을 하지 않으셨나요? <a href="#signup-modal" data-bs-toggle="modal" data-bs-dismiss="modal">회원가입</a>
									</div></div>
									</table>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
<%-- 		<!-- pwfind Modal-->
			<div class="modal fade" id="pwfind-modal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered p-2 my-0 mx-auto"
				style="max-width: 450px;">
				<div class="modal-content">
					<div class="modal-body px-0 py-2 py-sm-0">
						<button class="btn-close position-absolute top-0 end-0 mt-3 me-3"
							type="button" data-bs-dismiss="modal"></button>
						<div class="row mx-2 align-items-center">
							<div id="pwwrap">
								<c:if test="${empty pwdok}">
									<h2 class="pwtitle">비번찾기</h2>
									<form class="needs-validation" novalidate method="post"
										action="pwFindOk" onsubmit="return pwFindCheck()">
										<table id="pwt">
											<div class="mb-4">
												<label class="form-label mb-2" for="pwfind-id">아이디</label> <input
													class="form-control" type="text" id="pwfind-id" name="id"
													size="20" placeholder="아이디를 입력하세요" required>
											</div>
											<div class="mb-4">
												<label class="form-label mb-2" for="pwfind-name">이름</label>
												<input class="form-control" type="text" id="pwfind-name"
													name="id" size="20" placeholder="아이디를 입력하세요" required>
											</div>
										</table>
										<div id="pwmenu">
											<button class="btn btn-primary btn-lg rounded-pill w-100"
												value="찾기" type="submit">찾기</button>
											<button class="btn btn-primary btn-lg rounded-pill w-100"
												value="취소" type="reset" onclick="$('#pwfind-id').focus();">취소</button>
										</div>
										<div id="pwclose">
											<button class="btn btn-primary btn-lg rounded-pill w-100"
												value="닫기" onclick="self.close();">닫기</button>
										</div>
									</form>
								</c:if>

								<c:if test="${!empty pwdok}">
									<h2 class="pwtitle2">비번찾기 결과</h2>
									<table id="pwdt2">
										<tr>
											<th>검색한 비번:</th>
											<td>${pwdok}</td>
										</tr>
									</table>
									<div id="pwclose2">
										<button class="btn btn-primary btn-lg rounded-pill w-100"
											value="닫기" onclick="self.close();">닫기</button>
									</div>
								</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
			</div> --%>
			<!-- Sign Up Modal-->
		<div class="modal fade" id="signup-modal" tabindex="-1" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-centered p-2 my-0 mx-auto" style="max-width:500px;">
				<div class="modal-content" id="joinwrap">
					<div class="modal-body px-0 py-2 py-sm-0">
						<button class="btn-close position-absolute top-0 end-0 mt-3 me-3"
							type="button" data-bs-dismiss="modal"></button>
						<div class="row mx-2 align-items-center">
							<div class="col-md-12 px-5 pt-5 pb-5 px-sm-8 pb-sm-8 pt-md-8">
								<form class="needs-validation" novalidate="" name="f" method="post" action="joinOk" onsubmit="return check()" enctype="multipart/form-data">
									<table id="joint">
										<div class="mb-4">
											<label class="form-label;box" for="signup-id">아이디</label><br>
											<input class="form-control" type="text" style="width: 250px; float: left" id="signup-id" name="id" size="14" placeholder="아이디를 입력하세요" required="" /> 
											<input class="btn btn-primary btn-md rounded-pill w-20" type="button" style="float: right" value="중복확인" onclick="idcheck()" />
											<div id="idcheck"></div>
										</div><br>
										<div class="mb-4">
											<label class="form-label" for="signup-password">비밀번호</label>
											<div class="password-toggle">
												<input class="form-control" type="password"
													id="signup-password" placeholder="비밀번호를 8자리 이상 입력하세요" minlength="8" name="pw" size="14" class="box" required="">
												<label class="password-toggle-btn" aria-label="Show/hide password"> 
													<input class="password-toggle-check" type="checkbox"> 
													<span class="password-toggle-indicator"></span>
												</label>
											</div>
										</div>
										<div class="mb-4">
											<label class="form-label" for="signup-password-confirm">비밀번호 확인</label>
											<div class="password-toggle">
												<input class="form-control" type="password"
													id="signup-password-confirm" name="pw2" minlength="8" size="14" required="" /> 
													<label class="password-toggle-btn" aria-label="Show/hide password">
													<input class="password-toggle-check" type="checkbox">
													<span class="password-toggle-indicator"></span>
												</label>
											</div>
										</div>
										<div class="mb-4">
											<label class="form-label" for="signup-name">이름</label> <input
												class="form-control" type="text" id="signup-name" size="14" name="name"
												placeholder="이름을 입력하세요" required="" />
										</div>
										<div class="mb-4" id="send">
											<label class="form-label" for="signup-email">Email</label><br>
											<input class="form-control" type="email"
												style="width: 280px; float: left" id="signup-email"
												name="mail" size="10" placeholder="이메일을 입력하세요" required="" />
											<input class="btn btn-primary btn-md rounded-pill w-20"
												type="button" style="float: right" value="인증" onclick="send()" />
										</div><br><br>
										<div class="mb-4">
											<label class="form-label" for="signup-tel">연락처</label> <input
												class="form-control" type="text" id="signup-tel" name="tel"
												size="20" maxlength="20" value="${tel}" placeholder="연락처를 입력하세요" required="" />
										</div>
										<div class="mb-4">
											<label class="form-label" for="signup-post">우편번호</label><br>
											<input class="form-control" type="text" style="width: 200px; float: left" id="signup-post" name="post" size="5" placeholder="우편번호" required="" readonly onclick="postSearch()" /> 
											<input class="btn btn-primary btn-md rounded-pill w-20" type="button" style="float: right" value="우편번호검색" required="" onclick="openDaumPostcode()" />
										</div><br><br>
										<div class="mb-4">
											<label class="form-label" for="signup-address">주소</label> 
											<input class="form-control" type="text" id="signup-address" placeholder="주소를 입력하세요" size="50" name="addr1" required="" readonly onclick="postSearch()" />
										</div>
										<div class="mb-4">
											<label class="form-label" for="signup-address-detail">상세주소</label>
											<input class="form-control" type="text"
												id="signup-address-detail" placeholder="상세주소 입력"
												name="addr2" size="37" required="" />
										</div>
										<div class="mb-4">
											<label class="form-label" for="signup-address-detail">프로필사진</label>
											<input class="form-control" type="file" name="profiles"
												required="" />
										</div>
									</table>
									<div id="joinmenu">
									<button class="btn btn-primary btn-lg rounded-pill w-50"
										style="float: left" value="회원가입" type="submit">회원가입</button>
									<button class="btn btn-primary btn-lg rounded-pill w-50"
										style="float: right" value="취소" type="reset"
										onclick="$('#signup-id').focus();">취소</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Navbar-->
		<header class="navbar navbar-expand-lg navbar-light fixed-top" data-scroll-header>
			<div class="container">
				<a class="navbar-brand me-3 me-xl-4" href="city-guide-home-v1.html">
				<img class="d-block" src="img/logo/logo-dark.svg" width="116" alt="Finder"></a>
				<button class="navbar-toggler ms-auto" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarNav"
					aria-controls="navbarNav" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<c:choose>
				<c:when test="${empty sessionScope.id }">
				<a class="btn btn-sm text-primary d-none d-lg-block order-lg-3"
					href="#signin-modal" data-bs-toggle="modal"><i
					class="fi-user me-2"></i>로그인</a>
				</c:when>
				<c:when test="${!empty sessionScope.id }">
				<!-- <a class="btn btn-link fw-normal ms-sm-3 p-0" href="logout">로그아웃<i class="fi-user me-2"></i>
				</a> -->
				<a class="btn btn-sm text-primary d-none d-lg-block order-lg-3"
					href="logout" ><i
					class="fi-user me-2"></i>로그아웃</a>
				<a class="btn btn-sm text-primary d-none d-lg-block order-lg-3"
					href="myPage"><i
					class="fi-user me-2"></i>마이페이지</a>
				</c:when>
				
				</c:choose>	
				<div class="collapse navbar-collapse order-lg-2" id="navbarNav">
					<ul class="navbar-nav navbar-nav-scroll" style="max-height: 35rem;">
						<!-- Menu items-->
						<li class="nav-item dropdown active"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">Home</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="city-guide-home-v1.html">Homepage
										v.1</a></li>
								<li><a class="dropdown-item" href="city-guide-home-v2.html">Homepage
										v.2</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">Catalog</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="city-guide-catalog.html">Grid
										with Filters</a></li>
								<li><a class="dropdown-item" href="city-guide-single.html">Single
										Place - Gallery</a></li>
								<li><a class="dropdown-item"
									href="city-guide-single-info.html">Single Place - Info</a></li>
								<li><a class="dropdown-item"
									href="city-guide-single-reviews.html">Single Place -
										Reviews</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">Account</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item"
									href="city-guide-account-info.html">Personal Info</a></li>
								<li><a class="dropdown-item"
									href="city-guide-account-favorites.html">Favorites</a></li>
								<li><a class="dropdown-item"
									href="city-guide-account-reviews.html">Reviews</a></li>
								<li><a class="dropdown-item"
									href="city-guide-account-notifications.html">Notifications</a></li>
								<li><a class="dropdown-item" href="signin-light.html">Sign
										In</a></li>
								<li><a class="dropdown-item" href="signup-light.html">Sign
										Up</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">Vendor</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item"
									href="city-guide-add-business.html">Add Business</a></li>
								<li><a class="dropdown-item"
									href="city-guide-business-promotion.html">Business
										Promotion</a></li>
								<li><a class="dropdown-item"
									href="city-guide-vendor-businesses.html">My Businesses</a></li>
							</ul></li>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false">Pages</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="city-guide-about.html">About</a></li>
								<li class="dropdown"><a
									class="dropdown-item dropdown-toggle" href="#" role="button"
									data-bs-toggle="dropdown" aria-expanded="false">Blog</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="city-guide-blog.html">Blog
												Grid</a></li>
										<li><a class="dropdown-item"
											href="city-guide-blog-single.html">Single Post</a></li>
									</ul></li>
								<li><a class="dropdown-item"
									href="city-guide-contacts.html">Contacts</a></li>
								<li class="dropdown"><a
									class="dropdown-item dropdown-toggle" href="#" role="button"
									data-bs-toggle="dropdown" aria-expanded="false">Help Center</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item"
											href="city-guide-help-center.html">Help Topics</a></li>
										<li><a class="dropdown-item"
											href="city-guide-help-center-single-topic.html">Single
												Topic</a></li>
									</ul></li>
								<li><a class="dropdown-item" href="city-guide-404.html">404
										Not Found</a></li>
							</ul></li>
						<li class="nav-item d-lg-none"><a class="nav-link"
							href="#signin-modal" data-bs-toggle="modal"><i
								class="fi-user me-2"></i>Sign in</a></li>
					</ul>
				</div>
			</div>
		</header>
		<!-- Page content-->
		<!-- Hero-->
		<section class="container py-5 mt-5 mb-lg-3">
			<div class="row align-items-center mt-md-2">
				<div class="col-lg-7 order-lg-2 mb-lg-0 mb-4 pb-2 pb-lg-0">
					<img class="d-block mx-auto" src="img/city-guide/home/hero-img.jpg"
						width="746" alt="Hero image">
				</div>
				<div class="col-lg-5 order-lg-1 pe-lg-0">
					<h1 class="display-5 mb-4 me-lg-n5 text-lg-start text-center mb-4">
						Start exploring <span class="dropdown d-inline-block"><a
							class="dropdown-toggle text-decoration-none" href="#"
							role="button" data-bs-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false">Berlin</a><span
							class="dropdown-menu dropdown-menu-end my-1"><a
								class="dropdown-item fs-base fw-bold" href="#">Hamburg</a><a
								class="dropdown-item fs-base fw-bold" href="#">Munich</a><a
								class="dropdown-item fs-base fw-bold" href="#">Frankfurt am
									Main</a><a class="dropdown-item fs-base fw-bold" href="#">Stuttgart</a><a
								class="dropdown-item fs-base fw-bold" href="#">Cologne</a></span></span>
					</h1>
					<p class="text-lg-start text-center mb-4 mb-lg-5 fs-lg">Find
						great places to stay, eat, shop, or visit from our partners and
						local experts.</p>
					<!-- Search form-->
					<div class="me-lg-n5">
						<form
							class="form-group d-block d-md-flex position-relative rounded-md-pill me-lg-n5">
							<div class="input-group input-group-lg border-end-md">
								<span class="input-group-text text-muted rounded-pill ps-3"><i
									class="fi-search"></i></span> <input class="form-control" type="text"
									placeholder="What are you looking for?">
							</div>
							<hr class="d-md-none my-2">
							<div class="d-sm-flex">
								<div class="dropdown w-100 mb-sm-0 mb-3" data-bs-toggle="select">
									<button
										class="btn btn-link btn-lg dropdown-toggle ps-2 ps-sm-3"
										type="button" data-bs-toggle="dropdown">
										<i class="fi-list me-2"></i><span
											class="dropdown-toggle-label">All categories</span>
									</button>
									<input type="hidden">
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#"><i
												class="fi-bed fs-lg opacity-60 me-2"></i><span
												class="dropdown-item-label">Accomodation</span></a></li>
										<li><a class="dropdown-item" href="#"><i
												class="fi-cafe fs-lg opacity-60 me-2"></i><span
												class="dropdown-item-label">Food &amp; Drink</span></a></li>
										<li><a class="dropdown-item" href="#"><i
												class="fi-shopping-bag fs-lg opacity-60 me-2"></i><span
												class="dropdown-item-label">Shopping</span></a></li>
										<li><a class="dropdown-item" href="#"><i
												class="fi-museum fs-lg opacity-60 me-2"></i><span
												class="dropdown-item-label">Art &amp; History</span></a></li>
										<li><a class="dropdown-item" href="#"><i
												class="fi-entertainment fs-lg opacity-60 me-2"></i><span
												class="dropdown-item-label">Entertainment</span></a></li>
										<li><a class="dropdown-item" href="#"><i
												class="fi-meds fs-lg opacity-60 me-2"></i><span
												class="dropdown-item-label">Medicine</span></a></li>
										<li><a class="dropdown-item" href="#"><i
												class="fi-makeup fs-lg opacity-60 me-2"></i><span
												class="dropdown-item-label">Beauty</span></a></li>
										<li><a class="dropdown-item" href="#"><i
												class="fi-car fs-lg opacity-60 me-2"></i><span
												class="dropdown-item-label">Car Rental</span></a></li>
									</ul>
								</div>
								<button
									class="btn btn-primary btn-lg rounded-pill w-100 w-md-auto ms-sm-3"
									type="button">Search</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</section>

		<!-- Where to stay-->
		<section class="container mb-sm-5 mb-4 pb-lg-4">
			<div
				class="d-sm-flex align-items-center justify-content-between mb-4 pb-2">
				<h2 class="h3 mb-sm-0">랜드마크</h2>
				<a class="btn btn-link fw-normal ms-sm-3 p-0" href="list_form.html">모두
					보기<i class="fi-arrow-long-right ms-2"></i>
				</a>
			</div>
			<div
				class="tns-carousel-wrapper tns-controls-outside-xxl tns-nav-outside">
				<div class="tns-carousel-inner"
					data-carousel-options="{&quot;items&quot;: 3, &quot;gutter&quot;: 24, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1,&quot;nav&quot;:true},&quot;500&quot;:{&quot;items&quot;:2},&quot;850&quot;:{&quot;items&quot;:3},&quot;1400&quot;:{&quot;items&quot;:3,&quot;nav&quot;:false}}}">
					<!-- Item-->
					<article>
						<a class="d-block rounded-3 overflow-hidden"
							href="detail_page.html"><img class="d-block"
							src="img/car-finder/blog/05.jpg" alt="Image"></a>
						<div class="py-3">
							<h3 class="fs-base pt-1">
								<a class="nav-link" href="car-finder-blog-single.html">제목</a>
							</h3>
							<span class="star-rating"><i
								class="star-rating-icon fi-star-filled active"></i><i
								class="star-rating-icon fi-star-filled active"></i><i
								class="star-rating-icon fi-star-filled active"></i><i
								class="star-rating-icon fi-star"></i><i
								class="star-rating-icon fi-star"></i></span>
							<div class="ps-2">
								<div class="d-flex fs-xs opacity-60">
									<span><i class="fi-chat-circle me-1"></i>6 comments</span>
								</div>
							</div>
						</div>
					</article>
					<!-- Item-->
					<article>
						<a class="d-block rounded-3 overflow-hidden"
							href="car-finder-blog-single.html"><img class="d-block"
							src="img/car-finder/blog/04.jpg" alt="Image"></a>
						<div class="py-3">
							<a class="fs-xs text-uppercase text-decoration-none" href="#">Events</a>
							<h3 class="fs-base pt-1">
								<a class="nav-link" href="car-finder-blog-single.html">Top
									10 Classic Car Events</a>
							</h3>
							<div class="ps-2">
								<h6 class="fs-sm lh-base mb-1">Jacob Jones</h6>
								<div class="d-flex fs-xs opacity-60">
									<span class="me-2 pe-1"><i class="fi-calendar-alt me-1"></i>May
										8</span><span><i class="fi-chat-circle me-1"></i>No comments</span>
								</div>
							</div>
						</div>
					</article>
					<!-- Item-->
					<article>
						<a class="d-block rounded-3 overflow-hidden"
							href="car-finder-blog-single.html"><img class="d-block"
							src="img/car-finder/blog/05.jpg" alt="Image"></a>
						<div class="py-3">
							<a class="fs-xs text-uppercase text-decoration-none" href="#">Inspiration</a>
							<h3 class="fs-base pt-1">
								<a class="nav-link" href="car-finder-blog-single.html">5
									Predictions From the Past About the Future</a>
							</h3>
							<div class="ps-2">
								<h6 class="fs-sm lh-base mb-1">Guy Hawkins</h6>
								<div class="d-flex fs-xs opacity-60">
									<span class="me-2 pe-1"><i class="fi-calendar-alt me-1"></i>Apr
										25</span><span><i class="fi-chat-circle me-1"></i>6 comments</span>
								</div>
							</div>
						</div>
					</article>
					<!-- Item-->
					<article>
						<a class="d-block rounded-3 overflow-hidden"
							href="car-finder-blog-single.html"><img class="d-block"
							src="img/car-finder/blog/06.jpg" alt="Image"></a>
						<div class="py-3">
							<a class="fs-xs text-uppercase text-decoration-none" href="#">Test
								Drives</a>
							<h3 class=" fs-base pt-1">
								<a class="nav-link" href="car-finder-blog-single.html">This
									Year is All About New Harley Davidson</a>
							</h3>
							<div class="ps-2">
								<h6 class="fs-sm lh-base mb-1">Ralph Edwards</h6>
								<div class="d-flex fs-xs opacity-60">
									<span class="me-2 pe-1"><i class="fi-calendar-alt me-1"></i>Mar
										12</span><span><i class="fi-chat-circle me-1"></i>2 comments</span>
								</div>
							</div>
						</div>
					</article>
				</div>
			</div>
		</section>

		<!-- Banner + Where to eat-->
		<div class="container mb-5 pb-lg-4">
			<div class="row">
				<div
					class="d-flex align-items-center justify-content-between mb-4 pb-2">
					<h2 class="h2 mb-0">음식</h2>
					<a class="btn btn-link fw-normal ms-sm-3 p-0"
						href="city-guide-catalog.html">모두 보기<i
						class="fi-arrow-long-right ms-2"></i></a>
				</div>
				<!-- Banner-->
				<div class="col-lg-4 text-center text-lg-start mb-lg-0 mb-5">
					<div class="card border-0 h-100">
						<a class="d-block position-relative mb-3"
							href="city-guide-blog-single.html"><span
							class="badge bg-success position-absolute top-0 end-0 m-3 fs-sm">Sponsored</span><img
							class="rounded-3" src="img/city-guide/blog/04.jpg"
							alt="Post image"></a>
						<div class="card-body p-0">
							<a class="fs-sm text-uppercase text-decoration-none" href="#">Architecture</a>
							<h2 class="h5 pt-1 mb-2">
								<a class="nav-link" href="city-guide-blog-single.html">10
									Delightful Dining Room Decor Trends for Spring</a>
							</h2>
							<p class="fs-sm text-muted">Mi sit montes, aenean tempor
								sollicitudin volutpat viverra. Tellus amet, vitae ac consectetur
								blandit at. Odio proin elit, vehicula morbi faucibus vestibulum
								pulvinar posuere nisl tincidunt. Iaculis sit quam magna congue.</p>
							<div class="ps-2">
								<h6 class="fs-sm text-nav lh-base mb-1">Bessie Cooper</h6>
								<div class="d-flex text-body fs-xs">
									<span class="me-2 pe-1"><i
										class="fi-calendar-alt opacity-70 mt-n1 me-1 align-middle"></i>May
										24</span><span><i
										class="fi-chat-circle opacity-70 mt-n1 me-1 align-middle"></i>3
										comments</span>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Content-->
				<div class="col-lg-8 col-md-7 mb-5">

					<!-- Article-->
					<article class="card card-horizontal border-0 mb-4">
						<a
							class="card-img-top position-relative rounded-3 me-sm-4 mb-sm-0 mb-3"
							href="city-guide-blog-single.html"
							style="background-image: url(img/city-guide/blog/06.jpg);"><span
							class="badge bg-info position-absolute top-0 end-0 m-3 fs-sm">New</span></a>
						<div class="card-body px-0 pt-0 pb-lg-5 pb-sm-4 pb-2">
							<a class="fs-sm text-uppercase text-decoration-none" href="#">Travelling</a>
							<h3 class="h5 pt-1 mb-2">
								<a class="nav-link" href="city-guide-blog-single.html">Air
									Travel in the Time of COVID-19</a>
							</h3>
							<p class="fs-sm text-muted">Mi sit montes, aenean tempor
								sollicitudin volutpat viverra. Tellus amet, vitae ac consectetur
								blandit at. Odio proin elit, vehicula morbi faucibus vestibulum
								pulvinar posuere nisl tincidunt. Iaculis sit quam magna congue.</p>
							<div class="ps-2">
								<h6 class="fs-sm text-nav lh-base mb-1">Bessie Cooper</h6>
								<div class="d-flex text-body fs-xs">
									<span class="me-2 pe-1"><i
										class="fi-calendar-alt opacity-70 mt-n1 me-1 align-middle"></i>May
										24</span><span><i
										class="fi-chat-circle opacity-70 mt-n1 me-1 align-middle"></i>3
										comments</span>
								</div>
							</div>
						</div>
					</article>
					<!-- Article-->
					<article class="card card-horizontal border-0 mb-4">
						<a
							class="card-img-top position-relative rounded-3 me-sm-4 mb-sm-0 mb-3"
							href="city-guide-blog-single.html"
							style="background-image: url(img/city-guide/blog/06.jpg);"><span
							class="badge bg-info position-absolute top-0 end-0 m-3 fs-sm">New</span></a>
						<div class="card-body px-0 pt-0 pb-lg-5 pb-sm-4 pb-2">
							<a class="fs-sm text-uppercase text-decoration-none" href="#">Travelling</a>
							<h3 class="h5 pt-1 mb-2">
								<a class="nav-link" href="city-guide-blog-single.html">Air
									Travel in the Time of COVID-19</a>
							</h3>
							<p class="fs-sm text-muted">Mi sit montes, aenean tempor
								sollicitudin volutpat viverra. Tellus amet, vitae ac consectetur
								blandit at. Odio proin elit, vehicula morbi faucibus vestibulum
								pulvinar posuere nisl tincidunt. Iaculis sit quam magna congue.</p>
							<div class="ps-2">
								<h6 class="fs-sm text-nav lh-base mb-1">Bessie Cooper</h6>
								<div class="d-flex text-body fs-xs">
									<span class="me-2 pe-1"><i
										class="fi-calendar-alt opacity-70 mt-n1 me-1 align-middle"></i>May
										24</span><span><i
										class="fi-chat-circle opacity-70 mt-n1 me-1 align-middle"></i>3
										comments</span>
								</div>
							</div>
						</div>
					</article>
				</div>
			</div>
		</div>

		<!-- 숙소 -->
		<section class="container mb-5 pb-md-4">
			<div class="d-flex align-items-center justify-content-between mb-3">
				<h2 class="h3 mb-0">숙소</h2>
				<a class="btn btn-link fw-normal p-0"
					href="real-estate-catalog-rent.html">모두 보기<i
					class="fi-arrow-long-right ms-2"></i></a>
			</div>
			<div
				class="tns-carousel-wrapper tns-controls-outside-xxl tns-nav-outside tns-nav-outside-flush mx-n2">
				<div class="tns-carousel-inner row gx-4 mx-0 pt-3 pb-4"
					data-carousel-options="{&quot;items&quot;: 4, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2},&quot;768&quot;:{&quot;items&quot;:3},&quot;992&quot;:{&quot;items&quot;:4}}}">
					<!-- Item-->
					<div class="col">
						<div class="card shadow-sm card-hover border-0 h-100">
							<div class="card-img-top card-img-hover">
								<a class="img-overlay" href="real-estate-single-v1.html"></a>
								<div class="position-absolute start-0 top-0 pt-3 ps-3">
									<span class="d-table badge bg-success mb-1">Verified</span><span
										class="d-table badge bg-info">New</span>
								</div>
								<div class="content-overlay end-0 top-0 pt-3 pe-3">
									<button
										class="btn btn-icon btn-light btn-xs text-primary rounded-circle"
										type="button" data-bs-toggle="tooltip"
										data-bs-placement="left" title="Add to Wishlist">
										<i class="fi-heart"></i>
									</button>
								</div>
								<img src="img/real-estate/catalog/01.jpg" alt="Image">
							</div>
							<div class="card-body position-relative pb-3">
								<h4 class="mb-1 fs-xs fw-normal text-uppercase text-primary">For
									rent</h4>
								<h3 class="h6 mb-2 fs-base">
									<a class="nav-link stretched-link"
										href="real-estate-single-v1.html">3-bed Apartment | 67
										sq.m</a>
								</h3>
								<p class="mb-2 fs-sm text-muted">3811 Ditmars Blvd Astoria,
									NY 11105</p>
								<div class="fw-bold">
									<i class="fi-cash mt-n1 me-2 lead align-middle opacity-70"></i>$1,629
								</div>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-center mx-3 pt-3 text-nowrap">
								<span class="d-inline-block mx-1 px-2 fs-sm">3<i
									class="fi-bed ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">2<i
									class="fi-bath ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">2<i
									class="fi-car ms-1 mt-n1 fs-lg text-muted"></i></span>
							</div>
						</div>
					</div>
					<!-- Item-->
					<div class="col">
						<div class="card shadow-sm card-hover border-0 h-100">
							<div class="card-img-top card-img-hover">
								<a class="img-overlay" href="real-estate-single-v1.html"></a>
								<div class="position-absolute start-0 top-0 pt-3 ps-3">
									<span class="d-table badge bg-success mb-1">Verified</span><span
										class="d-table badge bg-danger">Featured</span>
								</div>
								<div class="content-overlay end-0 top-0 pt-3 pe-3">
									<button
										class="btn btn-icon btn-light btn-xs text-primary rounded-circle"
										type="button" data-bs-toggle="tooltip"
										data-bs-placement="left" title="Add to Wishlist">
										<i class="fi-heart"></i>
									</button>
								</div>
								<img src="img/real-estate/catalog/02.jpg" alt="Image">
							</div>
							<div class="card-body position-relative pb-3">
								<h4 class="mb-1 fs-xs fw-normal text-uppercase text-primary">For
									sale</h4>
								<h3 class="h6 mb-2 fs-base">
									<a class="nav-link stretched-link"
										href="real-estate-single-v1.html">Family Home| 120 sq.m</a>
								</h3>
								<p class="mb-2 fs-sm text-muted">67-04 Myrtle Ave Glendale,
									NY 11385</p>
								<div class="fw-bold">
									<i class="fi-cash mt-n1 me-2 lead align-middle opacity-70"></i>$84,000
								</div>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-center mx-3 pt-3 text-nowrap">
								<span class="d-inline-block mx-1 px-2 fs-sm">4<i
									class="fi-bed ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">2<i
									class="fi-bath ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">2<i
									class="fi-car ms-1 mt-n1 fs-lg text-muted"></i></span>
							</div>
						</div>
					</div>
					<!-- Item-->
					<div class="col">
						<div class="card shadow-sm card-hover border-0 h-100">
							<div class="card-img-top card-img-hover">
								<a class="img-overlay" href="real-estate-single-v1.html"></a>
								<div class="position-absolute start-0 top-0 pt-3 ps-3">
									<span class="d-table badge bg-success">Verified</span>
								</div>
								<div class="content-overlay end-0 top-0 pt-3 pe-3">
									<button
										class="btn btn-icon btn-light btn-xs text-primary rounded-circle"
										type="button" data-bs-toggle="tooltip"
										data-bs-placement="left" title="Add to Wishlist">
										<i class="fi-heart"></i>
									</button>
								</div>
								<img src="img/real-estate/catalog/03.jpg" alt="Image">
							</div>
							<div class="card-body position-relative pb-3">
								<h4 class="mb-1 fs-xs fw-normal text-uppercase text-primary">For
									rent</h4>
								<h3 class="h6 mb-2 fs-base">
									<a class="nav-link stretched-link"
										href="real-estate-single-v1.html">Greenpoint Rentals | 85
										sq.m</a>
								</h3>
								<p class="mb-2 fs-sm text-muted">1510 Castle Hill Ave Bronx,
									NY 10462</p>
								<div class="fw-bold">
									<i class="fi-cash mt-n1 me-2 lead align-middle opacity-70"></i>$1,330
								</div>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-center mx-3 pt-3 text-nowrap">
								<span class="d-inline-block mx-1 px-2 fs-sm">1<i
									class="fi-bed ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">1<i
									class="fi-bath ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">1<i
									class="fi-car ms-1 mt-n1 fs-lg text-muted"></i></span>
							</div>
						</div>
					</div>
					<!-- Item-->
					<div class="col">
						<div class="card shadow-sm card-hover border-0 h-100">
							<div class="card-img-top card-img-hover">
								<a class="img-overlay" href="real-estate-single-v1.html"></a>
								<div class="position-absolute start-0 top-0 pt-3 ps-3">
									<span class="d-table badge bg-success mb-1">Verified</span><span
										class="d-table badge bg-info">New</span>
								</div>
								<div class="content-overlay end-0 top-0 pt-3 pe-3">
									<button
										class="btn btn-icon btn-light btn-xs text-primary rounded-circle"
										type="button" data-bs-toggle="tooltip"
										data-bs-placement="left" title="Add to Wishlist">
										<i class="fi-heart"></i>
									</button>
								</div>
								<img src="img/real-estate/catalog/04.jpg" alt="Image">
							</div>
							<div class="card-body position-relative pb-3">
								<h4 class="mb-1 fs-xs fw-normal text-uppercase text-primary">For
									sale</h4>
								<h3 class="h6 mb-2 fs-base">
									<a class="nav-link stretched-link"
										href="real-estate-single-v1.html">Studio | 32 sq.m</a>
								</h3>
								<p class="mb-2 fs-sm text-muted">140-60 Beech Ave Flushing,
									NY 11355</p>
								<div class="fw-bold">
									<i class="fi-cash mt-n1 me-2 lead align-middle opacity-70"></i>$65,000
								</div>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-center mx-3 pt-3 text-nowrap">
								<span class="d-inline-block mx-1 px-2 fs-sm">1<i
									class="fi-bed ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">1<i
									class="fi-bath ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">2<i
									class="fi-car ms-1 mt-n1 fs-lg text-muted"></i></span>
							</div>
						</div>
					</div>
					<!-- Item-->
					<div class="col">
						<div class="card shadow-sm card-hover border-0 h-100">
							<div class="card-img-top card-img-hover">
								<a class="img-overlay" href="real-estate-single-v1.html"></a>
								<div class="position-absolute start-0 top-0 pt-3 ps-3">
									<span class="d-table badge bg-success mb-1">Verified</span>
								</div>
								<div class="content-overlay end-0 top-0 pt-3 pe-3">
									<button
										class="btn btn-icon btn-light btn-xs text-primary rounded-circle"
										type="button" data-bs-toggle="tooltip"
										data-bs-placement="left" title="Add to Wishlist">
										<i class="fi-heart"></i>
									</button>
								</div>
								<img src="img/real-estate/catalog/05.jpg" alt="Image">
							</div>
							<div class="card-body position-relative pb-3">
								<h4 class="mb-1 fs-xs fw-normal text-uppercase text-primary">For
									sale</h4>
								<h3 class="h6 mb-2 fs-base">
									<a class="nav-link stretched-link"
										href="real-estate-single-v1.html">Cottage | 120 sq.m</a>
								</h3>
								<p class="mb-2 fs-sm text-muted">42 Broadway New York, NY
									10004</p>
								<div class="fw-bold">
									<i class="fi-cash mt-n1 me-2 lead align-middle opacity-70"></i>$184,000
								</div>
							</div>
							<div
								class="card-footer d-flex align-items-center justify-content-center mx-3 pt-3 text-nowrap">
								<span class="d-inline-block mx-1 px-2 fs-sm">4<i
									class="fi-bed ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">2<i
									class="fi-bath ms-1 mt-n1 fs-lg text-muted"></i></span><span
									class="d-inline-block mx-1 px-2 fs-sm">1<i
									class="fi-car ms-1 mt-n1 fs-lg text-muted"></i></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Categories-->
		<section
			class="container d-flex flex-wrap flex-column flex-sm-row pb-5 mb-md-3">
			<a
				class="icon-box card flex-row align-items-center flex-shrink-0 card-hover border-0 shadow-sm rounded-pill py-2 ps-2 pe-4 mb-2 mb-sm-3 me-sm-3 me-xxl-4"
				href="city-guide-catalog.html">
				<div
					class="icon-box-media bg-faded-accent text-accent rounded-circle me-2">
					<i class="fi-bed"></i>
				</div>
				<h3 class="icon-box-title fs-sm ps-1 pe-2 mb-0">Accommodation</h3>
			</a><a
				class="icon-box card flex-row align-items-center flex-shrink-0 card-hover border-0 shadow-sm rounded-pill py-2 ps-2 pe-4 mb-2 mb-sm-3 me-sm-3 me-xxl-4"
				href="city-guide-catalog.html">
				<div
					class="icon-box-media bg-faded-warning text-warning rounded-circle me-2">
					<i class="fi-cafe"></i>
				</div>
				<h3 class="icon-box-title fs-sm ps-1 pe-2 mb-0">Food &amp;
					Drink</h3>
			</a><a
				class="icon-box card flex-row align-items-center flex-shrink-0 card-hover border-0 shadow-sm rounded-pill py-2 ps-2 pe-4 mb-2 mb-sm-3 me-sm-3 me-xxl-4"
				href="city-guide-catalog.html">
				<div
					class="icon-box-media bg-faded-primary text-primary rounded-circle me-2">
					<i class="fi-shopping-bag"></i>
				</div>
				<h3 class="icon-box-title fs-sm ps-1 pe-2 mb-0">Shopping</h3>
			</a><a
				class="icon-box card flex-row align-items-center flex-shrink-0 card-hover border-0 shadow-sm rounded-pill py-2 ps-2 pe-4 mb-2 mb-sm-3 me-sm-3 me-xxl-4"
				href="city-guide-catalog.html">
				<div
					class="icon-box-media bg-faded-success text-success rounded-circle me-2">
					<i class="fi-museum"></i>
				</div>
				<h3 class="icon-box-title fs-sm ps-1 pe-2 mb-0">Art &amp;
					History</h3>
			</a><a
				class="icon-box card flex-row align-items-center flex-shrink-0 card-hover border-0 shadow-sm rounded-pill py-2 ps-2 pe-4 mb-2 mb-sm-3 me-sm-3 me-xxl-4"
				href="city-guide-catalog.html">
				<div
					class="icon-box-media bg-faded-primary text-primary rounded-circle me-2">
					<i class="fi-entertainment"></i>
				</div>
				<h3 class="icon-box-title fs-sm ps-1 pe-2 mb-0">Entertainment</h3>
			</a>
			<div class="dropdown mb-2 mb-sm-3">
				<a
					class="icon-box card flex-row align-items-center flex-shrink-0 card-hover border-0 shadow-sm rounded-pill py-2 ps-2 pe-4"
					href="#" data-bs-toggle="dropdown">
					<div
						class="icon-box-media bg-faded-info text-info rounded-circle me-2">
						<i class="fi-dots-horisontal"></i>
					</div>
					<h3 class="icon-box-title fs-sm ps-1 pe-2 mb-0">More</h3>
				</a>
				<div class="dropdown-menu dropdown-menu-sm-end my-1">
					<a class="dropdown-item fw-bold" href="city-guide-catalog.html"><i
						class="fi-meds fs-base opacity-60 me-2"></i>Medicine</a><a
						class="dropdown-item fw-bold" href="city-guide-catalog.html"><i
						class="fi-makeup fs-base opacity-60 me-2"></i>Beauty</a><a
						class="dropdown-item fw-bold" href="city-guide-catalog.html"><i
						class="fi-car fs-base opacity-60 me-2"></i>Car Rental</a><a
						class="dropdown-item fw-bold" href="city-guide-catalog.html"><i
						class="fi-dumbell fs-base opacity-60 me-2"></i>Fitness &amp; Sport</a><a
						class="dropdown-item fw-bold" href="city-guide-catalog.html"><i
						class="fi-disco-ball fs-base opacity-60 me-2"></i>Night Club</a>
				</div>
			</div>
		</section>

		<!-- 지역 -->
		<section class="container mb-5 pb-2">
			<div class="d-flex align-items-center justify-content-between mb-3">
				<h2 class="h3 mb-0">지역</h2>
				<a class="btn btn-link fw-normal ms-md-3 pb-0"
					href="real-estate-catalog-rent.html">모두 보기<i
					class="fi-arrow-long-right ms-2"></i></a>
			</div>
			<div
				class="tns-carousel-wrapper tns-controls-outside-xxl tns-nav-outside tns-nav-outside-flush mx-n2">
				<div class="tns-carousel-inner row gx-4 mx-0 py-md-4 py-3"
					data-carousel-options="{&quot;items&quot;: 4, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2},&quot;768&quot;:{&quot;items&quot;:3},&quot;992&quot;:{&quot;items&quot;:4}}}">
					<!-- Item-->
					<div class="col">
						<a class="card shadow-sm card-hover border-0"
							href="real-estate-catalog-sale.html">
							<div class="card-img-top card-img-hover">
								<span class="img-overlay opacity-65"></span><img
									src="img/real-estate/city/new-york.jpg" alt="New York">
								<div
									class="content-overlay start-0 top-0 d-flex align-items-center justify-content-center w-100 h-100 p-3">
									<div class="w-100 p-1">
										<div class="mb-2">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-wallet mt-n1 me-2 fs-sm align-middle"></i>Property
												for sale
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-danger" role="progressbar"
														style="width: 30%" aria-valuenow="30" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">893</span>
											</div>
										</div>
										<div class="pt-1">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-home mt-n1 me-2 fs-sm align-middle"></i>Property
												for rent
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-success" role="progressbar"
														style="width: 85%" aria-valuenow="85" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">3756</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body text-center">
								<h3 class="mb-0 fs-base text-nav">New York</h3>
							</div>
						</a>
					</div>
					<!-- Item-->
					<div class="col">
						<a class="card shadow-sm card-hover border-0"
							href="real-estate-catalog-rent.html">
							<div class="card-img-top card-img-hover">
								<span class="img-overlay opacity-65"></span><img
									src="img/real-estate/city/chicago.jpg" alt="Chicago">
								<div
									class="content-overlay start-0 top-0 d-flex align-items-center justify-content-center w-100 h-100 p-3">
									<div class="w-100 p-1">
										<div class="mb-2">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-wallet mt-n1 me-2 fs-sm align-middle"></i>Property
												for sale
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-danger" role="progressbar"
														style="width: 37%" aria-valuenow="37" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">268</span>
											</div>
										</div>
										<div class="pt-1">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-home mt-n1 me-2 fs-sm align-middle"></i>Property
												for rent
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-success" role="progressbar"
														style="width: 80%" aria-valuenow="80" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">1540</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body text-center">
								<h3 class="mb-0 fs-base text-nav">Chicago</h3>
							</div>
						</a>
					</div>
					<!-- Item-->
					<div class="col">
						<a class="card shadow-sm card-hover border-0"
							href="real-estate-catalog-sale.html">
							<div class="card-img-top card-img-hover">
								<span class="img-overlay opacity-65"></span><img
									src="img/real-estate/city/los-angeles.jpg" alt="Los Angeles">
								<div
									class="content-overlay start-0 top-0 d-flex align-items-center justify-content-center w-100 h-100 p-3">
									<div class="w-100 p-1">
										<div class="mb-2">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-wallet mt-n1 me-2 fs-sm align-middle"></i>Property
												for sale
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-danger" role="progressbar"
														style="width: 75%" aria-valuenow="75" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">2750</span>
											</div>
										</div>
										<div class="pt-1">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-home mt-n1 me-2 fs-sm align-middle"></i>Property
												for rent
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-success" role="progressbar"
														style="width: 40%" aria-valuenow="40" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">692</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body text-center">
								<h3 class="mb-0 fs-base text-nav">Los Angeles</h3>
							</div>
						</a>
					</div>
					<!-- Item-->
					<div class="col">
						<a class="card shadow-sm card-hover border-0"
							href="real-estate-catalog-rent.html">
							<div class="card-img-top card-img-hover">
								<span class="img-overlay opacity-65"></span><img
									src="img/real-estate/city/san-diego.jpg" alt="San Diego">
								<div
									class="content-overlay start-0 top-0 d-flex align-items-center justify-content-center w-100 h-100 p-3">
									<div class="w-100 p-1">
										<div class="mb-2">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-wallet mt-n1 me-2 fs-sm align-middle"></i>Property
												for sale
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-danger" role="progressbar"
														style="width: 55%" aria-valuenow="55" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">1739</span>
											</div>
										</div>
										<div class="pt-1">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-home mt-n1 me-2 fs-sm align-middle"></i>Property
												for rent
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-success" role="progressbar"
														style="width: 60%" aria-valuenow="60" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">1854</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body text-center">
								<h3 class="mb-0 fs-base text-nav">San Diego</h3>
							</div>
						</a>
					</div>
					<!-- Item-->
					<div class="col">
						<a class="card shadow-sm card-hover border-0"
							href="real-estate-catalog-sale.html">
							<div class="card-img-top card-img-hover">
								<span class="img-overlay opacity-65"></span><img
									src="img/real-estate/city/dallas.jpg" alt="Dallas">
								<div
									class="content-overlay start-0 top-0 d-flex align-items-center justify-content-center w-100 h-100 p-3">
									<div class="w-100 p-1">
										<div class="mb-2">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-wallet mt-n1 me-2 fs-sm align-middle"></i>Property
												for sale
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-danger" role="progressbar"
														style="width: 90%" aria-valuenow="90" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">2567</span>
											</div>
										</div>
										<div class="pt-1">
											<h4 class="mb-2 fs-xs fw-normal text-light">
												<i class="fi-home mt-n1 me-2 fs-sm align-middle"></i>Property
												for rent
											</h4>
											<div class="d-flex align-items-center">
												<div class="progress progress-light w-100">
													<div class="progress-bar bg-success" role="progressbar"
														style="width: 50%" aria-valuenow="50" aria-valuemin="0"
														aria-valuemax="100"></div>
												</div>
												<span class="text-light fs-sm ps-1 ms-2">1204</span>
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body text-center">
								<h3 class="mb-0 fs-base text-nav">Dallas</h3>
							</div>
						</a>
					</div>
				</div>
			</div>
		</section>

		<!-- 최근 본 목록-->
		<section class="container pb-5 mb-lg-4">
			<div
				class="d-flex align-items-center justify-content-between mb-4 pb-2">
				<h2 class="h3 mb-0">최근 본 목록</h2>
				<a class="btn btn-link fw-normal ms-sm-3 p-0"
					href="city-guide-catalog.html">모두 보기<i
					class="fi-arrow-long-right ms-2"></i></a>
			</div>
			<div
				class="tns-carousel-wrapper tns-controls-outside-xxl tns-nav-outside mb-xxl-2">
				<div class="tns-carousel-inner"
					data-carousel-options="{&quot;items&quot;: 3, &quot;gutter&quot;: 24, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1,&quot;nav&quot;:true},&quot;500&quot;:{&quot;items&quot;:2},&quot;850&quot;:{&quot;items&quot;:3},&quot;1400&quot;:{&quot;items&quot;:3,&quot;nav&quot;:false}}}">
					<!-- Item-->
					<div>
						<div class="position-relative">
							<div class="position-relative mb-3">
								<button
									class="btn btn-icon btn-light-primary btn-xs text-primary rounded-circle position-absolute top-0 end-0 m-3 zindex-5"
									type="button" data-bs-toggle="tooltip" data-bs-placement="left"
									title="Add to Wishlist">
									<i class="fi-heart"></i>
								</button>
								<img class="rounded-3" src="img/city-guide/catalog/09.jpg"
									alt="Article img">
							</div>
							<h3 class="mb-2 fs-lg">
								<a class="nav-link stretched-link" href="#">Repose Hotel</a>
							</h3>
							<ul class="list-inline mb-0 fs-xs">
								<li class="list-inline-item pe-1"><i
									class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>5.0</b><span
									class="text-muted">&nbsp;(48)</span></li>
								<li class="list-inline-item pe-1"><i
									class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>$$</li>
								<li class="list-inline-item pe-1"><i
									class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>1.4
									km from center</li>
							</ul>
						</div>
					</div>
					<!-- Item-->
					<div>
						<div class="position-relative">
							<div class="position-relative mb-3">
								<button
									class="btn btn-icon btn-light-primary btn-xs text-primary rounded-circle position-absolute top-0 end-0 m-3 zindex-5"
									type="button" data-bs-toggle="tooltip" data-bs-placement="left"
									title="Add to Wishlist">
									<i class="fi-heart"></i>
								</button>
								<img class="rounded-3" src="img/city-guide/catalog/05.jpg"
									alt="Article img">
							</div>
							<h3 class="mb-2 fs-lg">
								<a class="nav-link stretched-link" href="#">Leisure Inn</a>
							</h3>
							<ul class="list-inline mb-0 fs-xs">
								<li class="list-inline-item pe-1"><i
									class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>4.8</b><span
									class="text-muted">&nbsp;(24)</span></li>
								<li class="list-inline-item pe-1"><i
									class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>$$$</li>
								<li class="list-inline-item pe-1"><i
									class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>0.5
									km from center</li>
							</ul>
						</div>
					</div>
					<!-- Item-->
					<div>
						<div class="position-relative">
							<div class="position-relative mb-3">
								<button
									class="btn btn-icon btn-light-primary btn-xs text-primary rounded-circle position-absolute top-0 end-0 m-3 zindex-5"
									type="button" data-bs-toggle="tooltip" data-bs-placement="left"
									title="Add to Wishlist">
									<i class="fi-heart"></i>
								</button>
								<img class="rounded-3" src="img/city-guide/catalog/11.jpg"
									alt="Article img">
							</div>
							<h3 class="mb-2 fs-lg">
								<a class="nav-link stretched-link" href="#">Soothe &amp;
									Stay</a>
							</h3>
							<ul class="list-inline mb-0 fs-xs">
								<li class="list-inline-item pe-1"><i
									class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>4.9</b><span
									class="text-muted">&nbsp;(43)</span></li>
								<li class="list-inline-item pe-1"><i
									class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>$$$</li>
								<li class="list-inline-item pe-1"><i
									class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>1.8
									km from center</li>
							</ul>
						</div>
					</div>
					<!-- Item-->
					<div>
						<div class="position-relative">
							<div class="position-relative mb-3">
								<button
									class="btn btn-icon btn-light-primary btn-xs text-primary rounded-circle position-absolute top-0 end-0 m-3 zindex-5"
									type="button" data-bs-toggle="tooltip" data-bs-placement="left"
									title="Add to Wishlist">
									<i class="fi-heart"></i>
								</button>
								<img class="rounded-3" src="img/city-guide/catalog/04.jpg"
									alt="Article img">
							</div>
							<h3 class="mb-2 fs-lg">
								<a class="nav-link stretched-link" href="#">Merry Berry
									Motel</a>
							</h3>
							<ul class="list-inline mb-0 fs-xs">
								<li class="list-inline-item pe-1"><i
									class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>4.5</b><span
									class="text-muted">&nbsp;(13)</span></li>
								<li class="list-inline-item pe-1"><i
									class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>$$</li>
								<li class="list-inline-item pe-1"><i
									class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>0.4
									km from center</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>

		<!-- Footer-->
		<footer class="footer bg-secondary pt-5">
			<div class="container pt-lg-4 pb-4">
				<!-- Links-->
				<div class="row mb-5 pb-md-3 pb-lg-4">
					<div class="col-lg-6 mb-lg-0 mb-4">
						<div
							class="d-flex flex-sm-row flex-column justify-content-between mx-n2">
							<div class="mb-sm-0 mb-4 px-2">
								<a class="d-inline-block mb-4" href="real-estate-home-v1.html"><img
									src="img/logo/logo-dark.svg" width="116" alt="logo"></a>
								<ul class="nav flex-column mb-sm-4 mb-2">
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="mailto:example@email.com"><i
											class="fi-mail mt-n1 me-2 align-middle opacity-70"></i>example@email.com</a></li>
									<li class="nav-item"><a class="nav-link p-0 fw-normal"
										href="tel:4065550120"><i
											class="fi-device-mobile mt-n1 me-2 align-middle opacity-70"></i>(406)
											555-0120</a></li>
								</ul>
								<div class="pt-2">
									<a
										class="btn btn-icon btn-light-primary btn-xs shadow-sm rounded-circle me-2 mb-2"
										href="#"><i class="fi-facebook"></i></a><a
										class="btn btn-icon btn-light-primary btn-xs shadow-sm rounded-circle me-2 mb-2"
										href="#"><i class="fi-twitter"></i></a><a
										class="btn btn-icon btn-light-primary btn-xs shadow-sm rounded-circle me-2 mb-2"
										href="#"><i class="fi-viber"></i></a><a
										class="btn btn-icon btn-light-primary btn-xs shadow-sm rounded-circle me-2 mb-2"
										href="#"><i class="fi-telegram"></i></a>
								</div>
							</div>
							<div class="mb-sm-0 mb-4 px-2">
								<h4 class="h5">Quick Links</h4>
								<ul class="nav flex-column">
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Buy a property</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Sell a property</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Rent a property</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Сalculate your
											property</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Top offers</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Top cities</a></li>
								</ul>
							</div>
							<div class="px-2">
								<h4 class="h5">About</h4>
								<ul class="nav flex-column">
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">About Us</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Our agents</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Help &amp; support</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">Contacts</a></li>
									<li class="nav-item mb-2"><a
										class="nav-link p-0 fw-normal" href="#">News</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
				<div class="text-center fs-sm pt-4 mt-3 pb-2">
					&copy; All rights reserved. Made by <a
						href='https://createx.studio/' class='d-inline-block nav-link p-0'
						target='_blank' rel='noopener'>Createx Studio</a>
				</div>
			</div>
		</footer>
		<!-- Back to top button-->
		<a class="btn-scroll-top" href="#top" data-scroll><span
			class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i
			class="btn-scroll-top-icon fi-chevron-up"> </i></a>
		<!-- Vendor scrits: js libraries and plugins-->
		<script src="vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
		<script src="vendor/simplebar/dist/simplebar.min.js"></script>
		<script src="vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
		<script src="vendor/tiny-slider/dist/min/tiny-slider.js"></script>
		<script src="vendor/flatpickr/dist/flatpickr.min.js"></script>
		<!-- Main theme script-->
		<script src="js/theme.min.js"></script>
		<!-- 회원가입 폼 -->
		<script src="js/member.js"></script>
		<!-- 비번찾기 폼 -->
        <script src="js/jquery.js"></script>
</body>
</html>