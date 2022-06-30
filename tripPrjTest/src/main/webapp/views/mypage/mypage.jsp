<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>My Page</title>
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

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>

function openDaumPostcode() {
	new daum.Postcode({
		oncomplete : function(data) {				
			document.getElementById('post').value = data.zonecode;
			document.getElementById('addr1').value = data.address;				
		}
	}).open();
}
</script>
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
<link rel="stylesheet" media="screen" href="vendor/simplebar/dist/simplebar.min.css" />
<link rel="stylesheet" media="screen" href="vendor/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css" />
<link rel="stylesheet" media="screen" href="vendor/filepond/dist/filepond.min.css" />
<!-- Main Theme Styles + Bootstrap-->
<link rel="stylesheet" media="screen" href="css/theme.min.css">
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
		<!-- Navbar-->
		<%@ include file="../navbar.jsp" %>
		<!-- Page content-->
		<div class="container pt-5 pb-lg-4 mt-5 mb-sm-2">
			<!-- Breadcrumb-->
			<nav class="mb-4 pt-md-3" aria-label="Breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="main">홈</a></li>
					<li class="breadcrumb-item"><a href="myPage">계정</a></li>
					<li class="breadcrumb-item active" aria-current="page">회원정보</li>
				</ol>
			</nav>
			<!-- Page content-->
			<form method="post" action="memberModify" enctype="multipart/form-data">
				  <input type="hidden" name="id" value="${sessionScope.id} ">
			<div class="row">
				<!-- Sidebar-->
				<aside class="col-lg-4 col-md-5 pe-xl-4 mb-5">
					<!-- Account nav-->
					<div class="card card-body border-0 shadow-sm pb-1 me-lg-1">
						<div class="d-flex d-md-block d-lg-flex align-items-start pt-lg-2 mb-1">
							<c:if test="${!empty detailM.profile}">
							<label for="input-file"><img class="rounded-circle" src="upload/${detailM.profile}" width="100"/></label>
							</c:if>
							<c:if test="${empty detailM.profile}">
							<label for="input-file"><img class="rounded-circle" src="img/avatars/13.png" width="100"/></label>
							</c:if>
							<input type="file" id="input-file" name="profiles" style="display: none">							
							<div class="pt-md-2 pt-lg-0 ps-3 ps-md-0 ps-lg-3">
								<h2 class="fs-lg mb-0">${detailM.id}</h2>
								<ul class="list-unstyled fs-sm mt-3 mb-0">
									<li><a class="nav-link fw-normal p-0" href="tel:3025550107"><i class="fi-phone opacity-60 me-2"></i>${detailM.tel}</a></li>
									<li><a class="nav-link fw-normal p-0" href="mailto:annette_black@email.com"><i class="fi-mail opacity-60 me-2"></i>${detailM.mail}</a></li>
								</ul>
							</div>							
						</div>
						<div class="collapse d-md-block mt-3" id="account-nav">
							<div class="card-nav">
								<a class="card-nav-link active" href="myPage">
								<i class="fi-user opacity-60 me-2"></i>개인 정보</a> 
								<a class="card-nav-link" href="myBookmarkList">
								<i class="fi-bookmark opacity-60 me-2"></i>북마크</a> 
								<a class="card-nav-link" href="myReviewList">
								<i class="fi-star opacity-60 me-2"></i>리뷰</a> 
								<a class="card-nav-link" href="myQnaList">
								<i class="fi-help opacity-60 me-2"></i>Q&A</a> 
								<a class="card-nav-link" href="mypageLogout">
								<i class="fi-logout opacity-60 me-2"></i>로그아웃</a>
							</div>
						</div>
					</div>
				</aside>
				<!-- Content-->
				<div class="col-lg-8 col-md-7 mb-5" >
					<h1 class="h2">개인 정보</h1>
						<div class="border rounded-3 p-3 mb-4" id="personal-info">
							<!-- Name-->
							<div class="border-bottom pb-2 mb-3">
								<div class="d-flex align-items-center justify-content-between">
									<div class="pe-2">
										<label class="form-label fw-bold">이름</label>
										<div id="name-value">${detailM.name}</div>
									</div>
									<div class="me-n3" data-bs-toggle="tooltip" title="Edit">
										<a class="nav-link py-0" href="#name-collapse" data-bs-toggle="collapse"><i class="fi-edit"></i></a>
									</div>
								</div>
								<div class="collapse" id="name-collapse" data-bs-parent="#personal-info">
									<input class="form-control mt-3" type="text" name="name" id="name" data-bs-unset-value="Not specified" value="${detailM.name}">
								</div>
							</div>
							<!-- Password-->
							<div class="border-bottom pb-2 mb-3">
								<div class="d-flex align-items-center justify-content-between">
									<div class="pe-2">
										<label class="form-label fw-bold">비밀번호</label>
										<div>${encrypt}</div>
									</div>
									<div class="me-n3" data-bs-toggle="tooltip" title="Edit">
										<a class="nav-link py-0" href="#password-collapse" data-bs-toggle="collapse"><i class="fi-edit"></i></a>
									</div>
								</div>
								<div class="collapse" id="password-collapse" data-bs-parent="#auth-info">
									<div class="row gx-3 align-items-center my-3">
										<label class="col-sm-4 col-md-3 col-form-label" for="account-password-current">새로운 비밀번호 :</label>
										<div class="col-sm-8 col-md-9">
											<div class="password-toggle">
												<input class="form-control" type="password" name="pw" id="pw" placeholder="Enter new password" required value="${detailM.pw}"> 
												<label class="password-toggle-btn" aria-label="Show/hide password">
													<input class="password-toggle-check" type="checkbox"><span class="password-toggle-indicator"></span>
												</label>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- Email-->
							<div class="border-bottom pb-2 mb-3">
								<div class="d-flex align-items-center justify-content-between">
									<div class="pe-2">
										<label class="form-label fw-bold">이메일</label>
										<div id="email-value">${detailM.mail}</div>
									</div>
									<div class="me-n3" data-bs-toggle="tooltip" title="Edit">
										<a class="nav-link py-0" href="#email-collapse" data-bs-toggle="collapse"><i class="fi-edit"></i></a>
									</div>
								</div>
								<div class="collapse" id="email-collapse" data-bs-parent="#personal-info">
									<input class="form-control mt-3" type="email" name="mail" id="mail" data-bs-unset-value="Not specified" value="${detailM.mail}">
								</div>
							</div>
							<!-- Phone number-->
							<div class="border-bottom pb-2 mb-3">
								<div class="d-flex align-items-center justify-content-between">
									<div class="pe-2">
										<label class="form-label fw-bold">연락처</label>
										<div id="phone-value">${detailM.tel}</div>
									</div>
									<div class="me-n3" data-bs-toggle="tooltip" title="Edit">
										<a class="nav-link py-0" href="#phone-collapse" data-bs-toggle="collapse"><i class="fi-edit"></i></a>
									</div>
								</div>
								<div class="collapse" id="phone-collapse" data-bs-parent="#personal-info">
									<input class="form-control mt-3" type="text" name="tel" id="tel" data-bs-unset-value="Not specified" value="${detailM.tel}">
								</div>
							</div>
							<!-- Address-->
							<div>
								<div class="d-flex align-items-center justify-content-between">
									<div class="pe-2">
										<label class="form-label fw-bold">주소</label>
										<div id="address-value">${detailM.addr1}</div>
									</div>
									<div class="me-n3" data-bs-toggle="tooltip" title="Edit">
										<a class="nav-link py-0" href="#address-collapse" data-bs-toggle="collapse"><i class="fi-edit"></i></a>
									</div>
								</div>
								<div class="collapse" id="address-collapse" data-bs-parent="#personal-info">
								<br>
								<div class="input-group">
									<input class="form-control" type="text" size="5" name="post" id="post" placeholder="우편번호" value="${detailM.post}">
	  								<button class="btn btn-primary" type="button" onclick="openDaumPostcode()">우편번호 검색</button>
								</div>
									<input class="form-control mt-3" type="text" name="addr1" id="addr1" data-bs-unset-value="Not specified" placeholder="주소" value="${detailM.addr1}">
									<input class="form-control mt-3" type="text" name="addr2" id="addr2" data-bs-unset-value="Not specified" placeholder="상세주소" value="${detailM.addr2}">
								</div>
							</div>
						</div>
						
						<!-- Button-->
						<div class="d-flex align-items-center justify-content-between mt-4 pt-4 pb-1">
							<button class="btn btn-primary px-3 px-sm-4" type="submit">프로필 수정</button>
							<!-- <form method="post" action="memberDeleteForm" enctype="multipart/form-data"> -->
								<%-- <input type="hidden" name="id" value="${sessionScope.id} "> --%>
								<button class="btn btn-link btn-sm px-0" type="button" onclick="location.href='memberDeleteForm';"><i class="fi-trash me-2"></i>회원 탈퇴</button> 
							<!-- </form> -->
						</div>
					<div class="d-flex align-items-center justify-content-between mt-4 pt-4 pb-1"></div>
				</div>
			</div>
			</form>
		</div>
	</main>
	
	<!-- Footer-->
	<footer class="footer bg-secondary pt-5">
		<!-- Banner-->
		<div class="text-center fs-sm pt-4 mt-3 pb-2">&copy; All rights reserved. Made by <a href='https://createx.studio/' class='d-inline-block nav-link p-0' target='_blank' rel='noopener'>Createx Studio</a></div>
	</footer>
	<!-- Back to top button-->
	<a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon fi-chevron-up"> </i></a>
	<!-- Vendor scrits: js libraries and plugins-->
	<script src="vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
	<script src="vendor/simplebar/dist/simplebar.min.js"></script>
	<script src="vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
	<script src="vendor/filepond-plugin-file-validate-type/dist/filepond-plugin-file-validate-type.min.js"></script>
	<script src="vendor/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.js"></script>
	<script src="vendor/filepond-plugin-image-crop/dist/filepond-plugin-image-crop.min.js"></script>
	<script src="vendor/filepond-plugin-image-resize/dist/filepond-plugin-image-resize.min.js"></script>
	<script src="vendor/filepond-plugin-image-transform/dist/filepond-plugin-image-transform.min.js"></script>
	<script src="vendor/filepond/dist/filepond.min.js"></script>
	<!-- Main theme script-->
	<script src="js/theme.min.js"></script>
</body>
</html>