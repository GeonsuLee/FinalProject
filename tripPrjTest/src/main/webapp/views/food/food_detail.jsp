<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>식당 상세 페이지</title>
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
    .page-loading.active > .page-loading-inner {
      opacity: 1;
    }
    .page-loading-inner > span {
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
    @-webkit-keyframes spinner {
      100% {
        -webkit-transform: rotate(360deg);
        transform: rotate(360deg);
      }
    }
    @keyframes spinner {
      100% {
        -webkit-transform: rotate(360deg);
        transform: rotate(360deg);
      }
    }

  </style>
  <!-- Page loading scripts-->
  <script>
    (function () {
      window.onload = function () {
        var preloader = document.querySelector('.page-loading');
        preloader.classList.remove('active');
        setTimeout(function () {
          preloader.remove();
        }, 2000);
      };
    })();
  </script>
  
  
  
  <!-- 리뷰 함수(비동기)-->
  <script src="webjars/jquery/dist/jquery.min.js"></script>
  <script type="text/javascript">
  
	// 리뷰 작성 모달로 이동
	function writes(food_id, page){
		 $('#writeform').load('foodReviewWriteModal?food_id='+food_id+'&page='+page);
	 }
  
  	// 리뷰 수정 모달로 이동
  	function modify(food_rev_id, food_id, page){
		 $('#modifyform').load('foodReviewModifyModal?food_rev_id='+food_rev_id+'&food_id='+food_id+'&page='+page);
	 }
	  
	// 리뷰 댓글 작성 모달로 이동
	 function reply(food_rev_id, page, food_id){
		 $('#replyform').load('foodReplyWriteModal?food_rev_id='+food_rev_id+'&food_id='+food_id+'&page='+page);
	 }


	// 리뷰 댓글 리스트 컨트롤러로 이동
	function replyList(food_rev_id, food_id, page){ 
		$('#seeMoreOverview_'+food_rev_id).load('foodReplyList?food_rev_id='+food_rev_id+'&food_id='+food_id+'&page='+page);	
	}
	
	// 리뷰 좋아요
	function foodlike(food_rev_id, food_id, page) {			
		alert("클릭");
		var id = $('#sessionScopeId').attr('value');
		var formData='food_rev_id='+food_rev_id+'&food_id='+food_id+'&page='+page+'&id='+id;
		$.post('foodReviewLike',formData, function(data) {
			
			history.go(0);
		});
	};
  </script>
  
  
  
  <!-- Vendor Styles-->
  <link rel="stylesheet" media="screen" href="vendor/simplebar/dist/simplebar.min.css"/>
  <link rel="stylesheet" media="screen" href="vendor/lightgallery.js/dist/css/lightgallery.min.css"/>
  <link rel="stylesheet" media="screen" href="vendor/tiny-slider/dist/tiny-slider.css"/>
  <link rel="stylesheet" media="screen" href="vendor/flatpickr/dist/flatpickr.min.css"/>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bbs.css" />
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/bbss.css" />
  <!-- Main Theme Styles + Bootstrap-->
  <link rel="stylesheet" media="screen" href="css/theme.min.css">
</head>
<!-- Delete-modal -->
<div id="delete-modal" class="modal fade" tabindex="-1" aria-hidden="true">
  <div class="modal-dialog-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Modal title</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Modal body text goes here.</p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary btn-sm" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary btn-sm">Save changes</button>
      </div>
    </div>
  </div>
</div>
<!-- Body-->
<body>
<!-- Page loading spinner-->
<div class="page-loading active">
  <div class="page-loading-inner">
    <div class="page-spinner"></div><span>Loading...</span>
  </div>
</div>
<main class="page-wrapper">
  <!-- Sign In Modal-->
  <%@ include file="../modal.jsp" %>
  <!-- Navbar-->
  <%@ include file="../navbar.jsp" %>
  <!-- Page content-->
  <section class="container mt-5 mb-lg-5 mb-4 pt-5 pb-lg-5">
    <!-- Breadcrumb-->
    <nav class="mb-3 pt-md-3" aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="main">홈</a></li>
        <li class="breadcrumb-item active" aria-current="page">식당</li>
      </ol>
    </nav>
    <!-- Features + Sharing-->
    <div class="d-flex justify-content-between align-items-center">
      <ul class="d-flex mb-4 list-unstyled">
      </ul>
      <div class="text-nowrap">
        <c:if test="${!empty sessionScope.id && isMark == false }">
        <button class="btn btn-icon  btn-xs shadow-sm rounded-circle ms-2 mb-2" type="button"  title="북마크 추가" onclick="location.href='addFoodMark?food_id=${food.food_id}&page=${page}&state=cont'"><i class="fi-bookmark"></i></button>
        </c:if>
         <c:if test="${!empty sessionScope.id && isMark == true }">
        <button class="btn btn-icon  btn-xs shadow-sm rounded-circle ms-2 mb-2" type="button"  title="북마크 삭제" onclick="location.href='addFoodMark?food_id=${food.food_id}&page=${page}&state=cont'"><i class="fi-bookmark-filled"></i></button>
         </c:if>
         <c:if test="${sessionScope.id eq 'admin'}">
         <div class="dropdown d-inline-block">
          <button class="btn btn-icon btn-light-primary btn-xs shadow-sm rounded-circle ms-2 mb-2" type="button" data-bs-toggle="dropdown"><i class="fi-dots-vertical"></i></button>
          <div class="dropdown-menu dropdown-menu-end my-1">
            <button class="dropdown-item" type="button" onclick="location.href='foodDetail?food_id=${food.food_id}&page=${page}&state=modify'"><i class="fi-edit opacity-60 me-2"></i>수정</button>
            <button class="dropdown-item" type="button" href="#food-delete-modal" data-bs-toggle="modal" data-bs-dismiss="modal"><i class="fi-trash opacity-60 me-2"></i>삭제</button>
          </div>
        </div>
        </c:if>
      </div>
    </div>

    <div class="row gy-5 pt-lg-2">
      <div class="col-lg-5">
        <div class="d-flex flex-column">
          <div class="order-lg-1 order-2">
            <div class="card py-2 px-sm-4 px-3 shadow-sm">
              <div class="card-body mx-n2">
                <!-- Place info-->
                <div class="d-flex align-items-start mb-3 pb-0 border-bottom">
                  <div class="ps-2 ms-1">
                    <h3 class="h4 mb-2">${food.food_name } <i class="fi-star-filled mt-n1 me-1 text-warning align-middle opacity-70"></i><b>${starAvg} </b>(${listCount})</h3>
                    <ul class="list-unstyled d-flex flex-wrap fs-md row-cols-md-1">
                      <li class="me-2 mb-2 pe-1"><i class="fi-cafe mt-n1 me-1 align-middle opacity-70"></i>${food.food_type } | ${food.food_feat } | ${food.food_menu}</li>
                      <li class="me-2 mb-2 pe-1"><i class="fi-map-pin mt-n1 me-1 align-middle opacity-70"></i>주소 ${food.food_addr }</li>
                      <li class="me-2 mb-2 pe-1"><i class="fi-phone mt-n1 me-1 align-middle opacity-70"></i>연락처 ${food.food_tel }</li>
                      <li class="me-2 mb-2 pe-1"><i class="fi-clock mt-n1 me-1 align-middle opacity-70"></i>영업시간 ${food.food_hour }</li>
                      <li class="me-2 mb-2 pe-1"><i class="fi-credit-card mt-n1 me-1 align-middle opacity-70"></i>₩ ${food.food_cost }</li>
                    </ul>
                  </div>
                </div>
                <!-- Place contacts-->
                <div class="mb-0 pb-0">
                  <h4 class="h4 mb-4">상세 정보</h4>
                  <ul class="list-unstyled d-flex flex-wrap row-cols-md-1">
                    <li class="h6 col"><i class="fi-car mt-n1 me-1 align-middle opacity-70"></i>이동 안내 및 소개</li>
                    <p class="mb-3">${food.food_content }</p>
                  </ul>
                </div>
              </div>
            </div>
            <!-- Not included in rent-->
            <div class="card border-0 bg-secondary mb-4">
            </div>
            <!-- Post meta-->
          </div>
        </div>
      </div>
      <!-- Sidebar with details-->
      <aside class="col-lg-7">
        <!-- Carousel with slides count-->
        <div class="order-lg-1 order-2">
          <div class="tns-carousel-wrapper">
            <div class="tns-slides-count text-light"><i class="fi-image fs-lg me-2"></i>
              <div class="ps-1"><span class="tns-current-slide fs-5 fw-bold"></span><span class="fs-5 fw-bold">/</span><span class="tns-total-slides fs-5 fw-bold"></span></div>
            </div>
            <div class="tns-carousel-inner" data-carousel-options="{&quot;navAsThumbnails&quot;: true, &quot;navContainer&quot;: &quot;#thumbnails&quot;, &quot;gutter&quot;: 12, &quot;responsive&quot;: {&quot;0&quot;:{&quot;controls&quot;: false},&quot;500&quot;:{&quot;controls&quot;: true}}}">
              <c:forTokens var="photo" items="${food.food_photo}" delims="," begin="0" end="4">
                <div><img class="rounded-3" src="<%=request.getContextPath()%>/upload/${photo}" alt="Image"/></div>
              </c:forTokens>
            </div>
          </div>
          <!-- Thumbnails nav-->
          <ul class="tns-thumbnails mb-4" id="thumbnails">
            <c:forTokens var="photo" items="${food.food_photo}" delims="," begin="0" end="4">
              <li class="tns-thumbnail"><img src="<%=request.getContextPath()%>/upload/${photo}" alt="Thumbnail"></li>
            </c:forTokens>
          </ul>
        </div>
      </aside>
      <section class="container mb-5 pb-1">
        <div class="row">
          <div class="col-md-7 mb-md-0 mb-4">
          <!-- 주변 식당-->
          <div class="col-lg-12">
            <div class="d-flex align-items-center justify-content-between mb-4 pb-2">
              <h6 class="mb-0">인근 지역</h6>
            </div>
              <p class="mb-5"><i class="fi-map-pin"></i>&ensp;${city }</p>
              <div class="row">
              <div class="col-sm-6">
                <!-- Item-->
                <c:set var="query" value="${queryList }"/>
                <div class="d-flex align-items-start position-relative mb-4"><img class="flex-shrink-0 me-3 rounded-3" src="img/city-guide/brands/01.svg" alt="Brand logo">
                  <div>
                    <h3 class="mb-2 fs-lg"><a class="nav-link stretched-link" href="city-guide-single.html">${query[0].place_name }</a></h3>
                    <ul class="list-unstyled mb-0 fs-xs">
                      <li><i class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>5.0</b><span class="text-muted">&nbsp;(48)</span></li>
                      <li><i class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>${query[0].place_type }</li>
                      <li><i class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>${query[0].place_addr }</li>
                    </ul>
                  </div>
                </div>
                <!-- Item-->
                <div class="d-flex align-items-start position-relative mb-4"><img class="flex-shrink-0 me-3 rounded-3" src="img/city-guide/brands/02.svg" alt="Brand logo">
                  <div>
                    <h3 class="mb-2 fs-lg"><a class="nav-link stretched-link" href="city-guide-single.html">${query[1].place_name }</a></h3>
                    <ul class="list-unstyled mb-0 fs-xs">
                      <li><i class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>4.0</b><span class="text-muted">&nbsp;(18)</span></li>
                      <li><i class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>${query[1].place_type }</li>
                      <li><i class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>${query[1].place_addr }</li>
                    </ul>
                  </div>
                </div>
                <div class="d-flex align-items-start position-relative mb-4"><img class="flex-shrink-0 me-3 rounded-3" src="img/city-guide/brands/02.svg" alt="Brand logo">
                  <div>
                    <h3 class="mb-2 fs-lg"><a class="nav-link stretched-link" href="city-guide-single.html">${query[2].place_name }</a></h3>
                    <ul class="list-unstyled mb-0 fs-xs">
                      <li><i class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>4.0</b><span class="text-muted">&nbsp;(18)</span></li>
                      <li><i class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>${query[2].place_type }</li>
                      <li><i class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>${query[2].place_addr }</li>
                    </ul>
                  </div>
                </div>
              </div>
              <div class="col-sm-6">
                <!-- Item-->
                <div class="d-flex align-items-start position-relative mb-4"><img class="flex-shrink-0 me-3 rounded-3" src="img/city-guide/brands/04.svg" alt="Brand logo">
                  <div>
                    <h3 class="mb-2 fs-lg"><a class="nav-link stretched-link" href="city-guide-single.html">${query[3].place_name }</a></h3>
                    <ul class="list-unstyled mb-0 fs-xs">
                      <li><i class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>5.0</b><span class="text-muted">&nbsp;(28)</span></li>
                      <li><i class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>${query[3].place_type }</li>
                      <li><i class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>${query[3].place_addr }</li>
                    </ul>
                  </div>
                </div>
                <!-- Item-->
                <div class="d-flex align-items-start position-relative mb-4"><img class="flex-shrink-0 me-3 rounded-3" src="img/city-guide/brands/05.svg" alt="Brand logo">
                  <div>
                    <h3 class="mb-2 fs-lg"><a class="nav-link stretched-link" href="city-guide-single.html">${query[4].place_name }</a></h3>
                    <ul class="list-unstyled mb-0 fs-xs">
                      <li><i class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>5.0</b><span class="text-muted">&nbsp;(43)</span></li>
                      <li><i class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>${query[4].place_type }</li>
                      <li><i class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>${query[4].place_addr }</li>
                    </ul>
                  </div>
                </div>
                <div class="d-flex align-items-start position-relative mb-4"><img class="flex-shrink-0 me-3 rounded-3" src="img/city-guide/brands/05.svg" alt="Brand logo">
                  <div>
                    <h3 class="mb-2 fs-lg"><a class="nav-link stretched-link" href="city-guide-single.html">${query[5].place_name }</a></h3>
                    <ul class="list-unstyled mb-0 fs-xs">
                      <li><i class="fi-star-filled mt-n1 me-1 fs-base text-warning align-middle"></i><b>5.0</b><span class="text-muted">&nbsp;(43)</span></li>
                      <li><i class="fi-credit-card mt-n1 me-1 fs-base text-muted align-middle"></i>${query[5].place_type }</li>
                      <li><i class="fi-map-pin mt-n1 me-1 fs-base text-muted align-middle"></i>${query[5].place_addr }</li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
          <!-- Sidebar-->
          <div class="col-lg-4 col-md-5 ms-lg-0 pb-1">
            <div class="pt-2">
              <div id="map" style="width:450px;height:500px;"></div>
            </div>
          </div>
          <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d94afef8490bb98bc1342c6224b71682&libraries=services"></script>
          <script>
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div
                    mapOption = {
                      center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                      level: 3 // 지도의 확대 레벨
                    };

            // 지도를 생성합니다
            var map = new kakao.maps.Map(mapContainer, mapOption);

            // 주소-좌표 변환 객체를 생성합니다
            var geocoder = new kakao.maps.services.Geocoder();

            // 주소로 좌표를 검색합니다
            geocoder.addressSearch('${food.food_addr}', function(result, status) {

              // 정상적으로 검색이 완료됐으면
              if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                  map: map,
                  position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                  content: '<div style="width:150px;text-align:center;padding:6px 0;">${food.food_name }</div>'
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
              }
            });
          </script>
        </div>
      </section>
    </div>
  </section>
</main>
<%@ include file="../food/food_qna_list.jsp" %>

<!-- Footer-->
<%@ include file="../footer.jsp" %>
<!-- Back to top button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon fi-chevron-up">   </i></a>
<!-- Vendor scrits: js libraries and plugins-->
<script src="vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="vendor/simplebar/dist/simplebar.min.js"></script>
<script src="vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
<script src="vendor/lightgallery.js/dist/js/lightgallery.min.js"></script>
<script src="vendor/lg-fullscreen.js/dist/lg-fullscreen.min.js"></script>
<script src="vendor/lg-zoom.js/dist/lg-zoom.min.js"></script>
<script src="vendor/lg-thumbnail.js/dist/lg-thumbnail.min.js"></script>
<script src="vendor/flatpickr/dist/flatpickr.min.js"></script>
<script src="vendor/tiny-slider/dist/min/tiny-slider.js"></script>
<!-- Main theme script-->
<script src="js/theme.min.js"></script>
</body>
</html>