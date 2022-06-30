<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>숙소 글 수정</title>
    <script src="http://code.jquery.com/jquery-latest.js"></script>
<%--    <script src="./views/room/room_modify.js"></script>--%>
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
    <!-- Vendor Styles-->
    <link rel="stylesheet" media="screen" href="vendor/simplebar/dist/simplebar.min.css"/>
    <link rel="stylesheet" media="screen" href="vendor/leaflet/dist/leaflet.css"/>
    <link rel="stylesheet" media="screen" href="vendor/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.css"/>
    <link rel="stylesheet" media="screen" href="vendor/filepond/dist/filepond.min.css"/>
    <!-- Main Theme Styles + Bootstrap-->
    <link rel="stylesheet" media="screen" href="css/theme.min.css">
  </head>
  <!-- Body-->
  <body class="bg-secondary">
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

      <!-- Page container-->
      <div class="container mt-5 mb-md-4 py-5">
        <div class="row">
          <!-- Page content-->
          <form enctype="multipart/form-data" action="roomModify" method="post">
           <input type="hidden" name="room_id" value="${room.room_id}" />
  		   <input type="hidden" name="page" value="${page}" />
  		  
          <div class="col-lg-8">
            <!-- Breadcrumb-->
            <nav class="mb-3 pt-2 pt-lg-3" aria-label="Breadcrumb">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="main">홈</a></li>
                <li class="breadcrumb-item active" aria-current="page">숙소</li>
              </ol>
            </nav>
            <!-- Title-->
            <div class="mb-4">
              <h1 class="h2 mb-0">숙소 글 수정</h1>
            </div>
            <!-- Basic info-->
            <section class="card card-body border-0 shadow-sm p-4 mb-4" id="basic-info">
              <h2 class="h4 mb-4"><i class="fi-info-circle text-primary fs-5 mt-n1 me-2"></i>정보</h2>
                <div class="col-sm-6 mb-3">
                  <label class="form-label" for="ab-title">숙소 이름 <span class="text-danger">*</span></label>
                  <input class="form-control" type="text" id="room_name" name="room_name" value="${room.room_name}" placeholder="명소 이름을 입력하세요" required><span class="form-text"></span>
                </div>
              <div class="col-sm-6 mb-3">
                <label class="form-label" for="ab-title">옵션<span class="text-danger">*</span></label>
                <input class="form-control" id="room_option" name="room_option" value="${room.room_option}" placeholder="숙소 옵션을 입력하세요" required><span class="form-text"></span>
              </div>

              <div class="col-sm-6 mb-3">
                <label class="form-label" for="ab-subcategory">세부 유형<span class="text-danger">*</span></label>
                <select class="form-select" id="room_type" name="room_type" value="${room.room_type}" required>
                  <option value="" disabled>유형을 선택하세요</option>
                    <option value="${room.room_type}"><c:if test="${room.room_type}">${'selected'}</c:if>${room.room_type}</option>
                  <option value="호텔">호텔</option>
                  <option value="펜션">펜션</option>
                  <option value="캠핑장">캠핑장</option>
                  <option value="게스트하우스">게스트하우스</option>
                  <option value="기타">기타</option>
                </select>
              </div>
              
            <!-- Contacts-->
                <div class="col-sm-6 mb-3">
                  <label class="form-label" for="ab-phone">연락처 <span class="text-danger">*</span></label>
                  <input class="form-control" type="tel" id="room_tel" name="room_tel" value="${room.room_tel}" placeholder="연락처를 입력하세요(-제외)" required>
                </div>

                <div class="col-sm-6 mb-3">
                  <label class="form-label" for="ab-title">주소 <span class="text-danger">*</span></label>
                  <input class="form-control" type="text" id="room_addr" name="room_addr" value="${room.room_addr}" placeholder="주소를 입력하세요" required>
                </div>
              <!-- 설명 -->
              <label class="form-label" for="ab-description">소개 <span class="text-danger">*</span></label>
              <div class="row mb-4">
                <div class="col-md-9 mb-md-0 mb-3">
                  <textarea class="form-control" id="room_content" name="room_content" rows="6" placeholder="소개를 입력하세요" required>${room.room_content}</textarea><span class="form-text"></span>
                </div>
              </div>
                <!-- 성급 -->
                <div class="col-sm-6 mb-3">
                    <label class="form-label" for="ab-title">성급<span class="text-danger">*</span></label>
                    <select class="form-select" id="room_star" name="room_star" value="${room.room_star}" required>
                        <option value="" disabled>성급을 선택하세요</option>
                        <option value="${room.room_star}"><c:if test="${room.room_star}">${'selected'}</c:if>${room.room_star}</option>
                        <option value="5성급">5성급</option>
                        <option value="4성급">4성급</option>
                        <option value="3성급">3성급</option>
                        <option value="2성급">2성급</option>
                    </select>
                </div>
              <!-- 가격 -->
              <div class="col-sm-6 mb-3">
                <label class="form-label" for="ab-title">가격 <span class="text-danger">*</span></label>
                <input class="form-control" type="text" id="room_cost" name="room_cost" value="${room.room_cost}" placeholder="가격을 입력하세요" required>
              </div>
            </section>
            
            <!-- Photos / video-->
            <section class="card card-body border-0 shadow-sm p-4 mb-4" enctype="multipart/form-data" >
              <h2 class="h4 mb-4"><i class="fi-image text-primary fs-5 mt-n1 me-2"></i>사진 / 파일</h2>
              <div class="alert alert-info mb-4" role="alert">
                <div class="d-flex"><i class="fi-alert-circle me-2 me-sm-3"></i>
                  <p class="fs-sm mb-1">The maximum photo size is 8 MB. 사진 형식: jpeg, jpg, png. Put the main picture first.<br>The maximum video size is 10 MB. Formats: mp4, mov.</p>
                </div>
              </div>
              <input type="file" id="room_photos" name="room_photos" multiple>
             <!--  <input class="file-uploader file-uploader-grid" type="file" id=room_photo1 name="room_photo1" multiple data-max-file-size="10MB" accept="image/png, image/jpeg, video/mp4, video/mov" data-label-idle="&lt;div class=&quot;btn btn-primary rounded-pill mb-3&quot;&gt;&lt;i class=&quot;fi-cloud-upload me-1&quot;&gt;&lt;/i&gt;사진 / 파일 업로드&lt;/div&gt;&lt;br&gt;or drag them in"> -->
            </section>
            
            <div class="d-sm-flex justify-content-between pt-2">
               <button class="btn btn-primary btn-lg d-block rounded-pill mb-2" type="submit">저장하기</button>
            </div>
            <!-- Action buttons -->
           <!--  <section class="d-sm-flex justify-content-between pt-2"><a class="btn btn-outline-primary btn-lg d-block rounded-pill mb-3 mb-sm-2" href="#preview-modal" data-bs-toggle="modal"><i class="fi-eye-on ms-n1 me-2"></i>미리보기</a><button class="btn btn-primary btn-lg d-block rounded-pill mb-2" type="submit">저장하기</button></section> -->
          </div>
         </form>
         
        </div>
      </div>
    </main>
    <!-- Banner-->
    <div class="text-center fs-sm pt-4 mt-3 pb-2">&copy; All rights reserved. Made by <a href='https://createx.studio/' class='d-inline-block nav-link p-0' target='_blank' rel='noopener'>Createx Studio</a></div>
  </div>
</footer>
<!-- Back to top button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon fi-chevron-up">   </i></a>
<!-- Vendor scrits: js libraries and plugins-->
<script src="vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
<script src="vendor/simplebar/dist/simplebar.min.js"></script>
<script src="vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
<script src="vendor/leaflet/dist/leaflet.js"></script>
<script src="vendor/filepond-plugin-file-validate-type/dist/filepond-plugin-file-validate-type.min.js"></script>
<script src="vendor/filepond-plugin-file-validate-size/dist/filepond-plugin-file-validate-size.min.js"></script>
<script src="vendor/filepond-plugin-image-preview/dist/filepond-plugin-image-preview.min.js"></script>
<script src="vendor/filepond-plugin-image-crop/dist/filepond-plugin-image-crop.min.js"></script>
<script src="vendor/filepond-plugin-image-resize/dist/filepond-plugin-image-resize.min.js"></script>
<script src="vendor/filepond-plugin-image-transform/dist/filepond-plugin-image-transform.min.js"></script>
<script src="vendor/filepond/dist/filepond.min.js"></script>
<script src="vendor/cleave.js/dist/cleave.min.js"></script>
<!-- Main theme script-->
<script src="js/theme.min.js"></script>
</body>
</html>