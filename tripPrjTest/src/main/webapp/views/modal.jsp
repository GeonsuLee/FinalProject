<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript" src="func/member.js"></script>

<script>
	var mywin; //전역변수
</script>

<!-- 인증값이 있을때  -->
<c:if test="${!empty idok }"> 
	<script>
	 	window.opener.location.reload();
	 	window.close();
	</script>
</c:if>	

<!-- 인증값이 없을때  -->
<c:if test="${empty idok }">
<script>
	function popupKakaoLogin() {
		mywin = window.open('https://kauth.kakao.com/oauth/authorize?client_id=7e436f026896af8927b747e85c5fd911&redirect_uri=http://localhost/kakaoLogin&response_type=code','popupKakaoLogin', 'width=700,height=500,scrollbars=0,toolbar=0,menubar=no');	
	}
</script>

<div class="modal fade" id="signin-modal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered p-2 my-0 mx-auto" style="max-width: 450px;">
		<div class="modal-content">
			<div class="modal-body px-0 py-2 py-sm-0">
				<button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal"></button>
				    <div class="row mx-2 align-items-center">
					<div class="col-md-12 px-5 pt-5 pb-5 px-sm-8 pb-sm-8 pt-md-8">
						<!-- <a class="btn btn-outline-info d-block w-100 mb-3" href="#">
						<i class="fi-google fs-lg me-1"></i>구글로 로그인하기</a> -->
						<a class="btn btn-outline-warning d-block w-100 mb-3" onclick="popupKakaoLogin()" href="#">
						<i class="fi-chat-circle fs-lg me-1"></i> 카카오로 로그인하기</a>
						<div class="d-flex align-items-center py-3 mb-1">
							<hr class="w-100">
							<div class="px-3">Or</div>
							<hr class="w-100">
						</div>
						 <div id="loginwrap">
						<form class="needs-validation" novalidate method="post" action="loginOk" onsubmit="return checks()">
							<table id="logint">
							<div class="mb-3">
								<label class="form-label mb-2" for="signin-email">아이디</label>
								<input class="form-control" type="text" id="signin-email" name="id" size="20" placeholder="아이디를 입력하세요" required>
							</div>
							<div class="mb-3">
								<div class="d-flex align-items-center justify-content-between mb-2">
								<label class="form-label mb-0" for="signin-password">비밀번호</label>
								<a class="fs-sm" href="#pwfind-modal" data-bs-toggle="modal" data-bs-dismiss="modal">비밀번호를 잊으셨나요?</a>
								</div>
								<div class="mb-3">
									<div class="password-toggle">
										<input class="form-control" type="password" id="signin-password"  name="pw" size="20" placeholder="비밀번호를 입력하세요" required>
										<label class="password-toggle-btn" aria-label="Show/hide password"> 
										<input class="password-toggle-check" type="checkbox">
										<span class="password-toggle-indicator"></span>
										</label>
									</div>
								</div>      
								<div class="form-check mb-3">
									<input class="form-check-input" type="checkbox" id="agree-to-terms"> 
									<label class="form-check-label" for="agree-to-terms">로그인 유지</label>
								</div>
							</div>
							<div id="loginmenu">
							<button class="btn btn-primary btn-lg d-block w-100" type="submit">로그인</button>
							<div class="mt-3 mt-sm-4"><p style="font-size: 14px; display: inline-block;">아직 회원가입을 하지 않으셨나요?</p><a class="fs-sm" href="#signup-modal" data-bs-toggle="modal" data-bs-dismiss="modal" style="float: right">회원가입</a>
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
<!-- Find PW Modal-->
<div class="modal fade" id="pwfind-modal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-xl modal-dialog-centered p-2 my-0 mx-auto" style="max-width: 450px;">
		<div class="modal-content">
			<div class="modal-body px-0 py-30 py-md-50">
				<button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal"></button>
				<div class="row mx-2 align-items-center">
					<div id="pwwrap">
						<c:if test="${empty pwdok}">
							<br><h5 class="pwtitle">아이디와 이름을 입력해주세요</h5>
							<form class="needs-validation" novalidate method="post" action="pwFindOk" onsubmit="return pwFindCheck()">
								<table id="pwt">
									<div class="mb-3">
										<label class="form-label mb-2" for="pwfind-id">아이디</label>
										<input class="form-control" type="text" id="pwfind-id" name="id" size="20" placeholder="아이디를 입력하세요" required>
									</div>
									<div class="mb-5">
										<label class="form-label mb-2" for="pwfind-name">이름</label>
										<input class="form-control" type="text" id="pwfind-name" name="name" size="20" placeholder="이름을 입력하세요" required>
									</div>
								</table>
								<div id="pwmenu">
								<button class="btn btn-primary d-block w-100" type="submit" data-target="#pwfindok-modal" data-bs-toggle="modal" data-bs-dismiss="modal">비밀번호 찾기</button>
								</div>
							</form>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Sign Up Modal-->
<div class="modal fade" id="signup-modal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered p-2 my-0 mx-auto" style="max-width:500px;">
		<div class="modal-content" id="joinwrap">
			<div class="modal-body px-0 py-2 py-sm-0">
				<button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal"></button>
				<div class="row mx-2 align-items-center">
					<div class="col-md-12 px-5 pt-5 pb-5 px-sm-8 pb-sm-8 pt-md-8">
						<form class="needs-validation" novalidate="" name="f" method="post" action="joinOk" onsubmit="return check()" enctype="multipart/form-data">
							<table id="joint">
								<div class="mb-3">
									<label class="form-label;box" for="signup-id">아이디</label><br>
									<input class="form-control" type="text" style="width: 250px; float: left" id="signup-id" name="id" size="14" placeholder="아이디를 입력하세요" required="" /> 
									<input class="btn btn-translucent-primary w-20" type="button" style="float: right" value="중복확인" onclick="idcheck()"/>
									<div id="idcheck"></div>
								</div><br><br>
								<div class="mb-3">
									<label class="form-label" for="signup-password">비밀번호</label>
									<div class="password-toggle">
										<input class="form-control" type="password" id="signup-password" placeholder="비밀번호를 8자리 이상 입력하세요" minlength="8" name="pw" size="14" class="box" required="">
										<label class="password-toggle-btn" aria-label="Show/hide password"> 
											<input class="password-toggle-check" type="checkbox"> 
											<span class="password-toggle-indicator"></span>
										</label>
									</div>
								</div>
								<div class="mb-3">
									<label class="form-label" for="signup-password-confirm">비밀번호 확인</label>
									<div class="password-toggle">
										<input class="form-control" type="password" id="signup-password-confirm" name="pw2" minlength="8" size="14" required="" /> 
										<label class="password-toggle-btn" aria-label="Show/hide password">
											<input class="password-toggle-check" type="checkbox">
											<span class="password-toggle-indicator"></span>
										</label>
									</div>
								</div>
								<div class="mb-3">
									<label class="form-label" for="signup-name">이름</label> <input class="form-control" type="text" id="signup-name" size="14" name="name" placeholder="이름을 입력하세요" required="" />
								</div>
								<div class="mb-1">
									<label class="form-label" for="signup-email">Email</label><br>
									<input class="form-control" type="email" style="width: 275px; float: left" id="signup-email" name="mail" size="10" placeholder="이메일을 입력하세요" required="required" />
									<input class="btn btn-translucent-primary w-20" id=signup-email-butten type="button" style="width: 82px; float: right" value="인증" onclick="send();" />
								</div><br><br>
								<div class="mb-3" id="mailtoken">
									<input class="form-control" type="text" style="width:275px; float:left;" id="signup-emailtoken" name="token" size="10" placeholder="인증번호를 입력하세요" required="" />
									<input class="btn btn-translucent-primary w-20" id=maildoublecheck type="button" style="float: right" value="확인" onclick="mailcheck()" />
								</div><br>
								<div class="mb-3">
									<label class="form-label" for="signup-tel">연락처</label>
									<input class="form-control" type="text" id="signup-tel" name="tel" size="20" maxlength="20" value="${tel}" placeholder="연락처를 입력하세요" required="" />
								</div>
								<div class="mb-3">
									<label class="form-label" for="signup-post">우편번호</label><br>
									<input class="form-control" type="text" style="width: 200px; float: left" id="signup-post" name="post" size="5" placeholder="우편번호" required="" readonly onclick="postSearch()" /> 
									<input class="btn btn-translucent-primary w-20" type="button" style="float: right" value="우편번호 검색" required="" onclick="openDaumPostcode()" />
								</div><br><br>
								<div class="mb-3">
									<label class="form-label" for="signup-address">주소</label> 
									<input class="form-control" type="text" id="signup-address" placeholder="주소를 입력하세요" size="50" name="addr1" required="" readonly onclick="postSearch()" />
								</div>
								<div class="mb-3">
									<label class="form-label" for="signup-address-detail">상세주소</label>
									<input class="form-control" type="text" id="signup-address-detail" placeholder="상세주소 입력" name="addr2" size="37" required="" />
								</div>
								<div class="mb-3">
									<label class="form-label" for="signup-address-detail">프로필사진</label>
									<input class="form-control" type="file" name="profiles"/>
								</div>
							</table>
							<div id="joinmenu">
							<button class="btn btn-primary d-block w-100"value="회원가입" type="submit">회원가입</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

</c:if>

<!-- food delete modal-->
<form method="post" action="foodDelete" onsubmit="return del_check()">
	<input type="hidden" name="food_id" value="${food.food_id}" />
	<input type="hidden" name="page" value="${page}" />
	<div class="modal fade" id="food-delete-modal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document" style="width: 24rem;">
			<div class="modal-content">
				<div class="modal-body">
					<p>정말 삭제 하시겠습니까?</p>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary btn-sm">삭제</button>
					<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- place delete modal-->
<form method="post" action="placeDelete" onsubmit="return del_check()">
	<input type="hidden" name="place_id" value="${place.place_id}" />
	<input type="hidden" name="page" value="${page}" />
	<div class="modal fade" id="place-delete-modal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document" style="width: 24rem;">
			<div class="modal-content">
				<div class="modal-body">
					<p>정말 삭제 하시겠습니까?</p>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary btn-sm">삭제</button>
					<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</form>

<!-- room delete modal-->
<form method="post" action="roomDelete" onsubmit="return del_check()">
	<input type="hidden" name="room_id" value="${room.room_id}" />
	<input type="hidden" name="page" value="${page}" />
	<div class="modal fade" id="room-delete-modal" tabindex="-1" role="dialog">
		<div class="modal-dialog modal-dialog-centered" role="document" style="width: 24rem;">
			<div class="modal-content">
				<div class="modal-body">
					<p>정말 삭제 하시겠습니까?</p>
				</div>
				<div class="modal-footer">
					<button type="submit" class="btn btn-primary btn-sm">삭제</button>
					<button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
</form>