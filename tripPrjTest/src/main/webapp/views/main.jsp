<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Main Page</title>
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
    <link rel="stylesheet" media="screen" href="vendor/tiny-slider/dist/tiny-slider.css"/>
    <link rel="stylesheet" media="screen" href="vendor/flatpickr/dist/flatpickr.min.css"/>
    <!-- Main Theme Styles + Bootstrap-->
    <link rel="stylesheet" media="screen" href="css/theme.min.css">
  </head>
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
      <%@ include file="modal.jsp" %>
      <!-- Navbar-->
      <%@ include file="navbar.jsp" %>
      <!-- Page content-->
      <!-- Hero-->
      <section class="container py-5 mt-5 mb-lg-3">
        <div class="row align-items-center mt-md-2">
          <div class="col-lg-7 order-lg-2 mb-lg-0 mb-4 pb-2 pb-lg-0"><img class="d-block mx-auto" src="upload/KakaoTalk_20220603_113305232.jpg" width="746" alt="Hero image"></div>
          <div class="col-lg-5 order-lg-1 pe-lg-0">
            <h1 class="display-5 mb-4 me-lg-n5 text-lg-start text-center mb-4">My Seoul Trip</h1>
            <p class="text-lg-start text-center mb-4 mb-lg-5 fs-lg">서울의 곳곳의 가 볼 만한 명소를 소개합니다.</p>
            <!-- Search form-->
            <div class="me-lg-n5">
              <form class="form-group d-block d-md-flex position-relative rounded-md-pill me-lg-n5" action="search">
                <div class="input-group input-group-lg border-end-md"><span class="input-group-text text-muted rounded-pill ps-3"><i class="fi-search"></i></span>
                  <input class="form-control" type="text" name="input" placeholder="어디로 가시나요?">
                </div>
                <hr class="d-md-none my-2">
                <div class="d-sm-flex">
                  <button class="btn btn-primary btn-lg rounded-pill w-100 w-md-auto ms-sm-3" type="submit">검색</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </section>
      
      <!-- 명소 -->
      <section class="container mb-sm-5 mb-4 pb-lg-4">
        <div class="d-sm-flex align-items-center justify-content-between mb-4 pb-2">
          <h2 class="h3 mb-sm-0">명소</h2><a class="btn btn-link fw-normal ms-sm-3 p-0" href="placeList">더보기<i class="fi-arrow-long-right ms-2"></i></a>
        </div>
        <div class="tns-carousel-wrapper tns-controls-outside-xxl tns-nav-outside">
          <div class="tns-carousel-inner" data-carousel-options="{&quot;items&quot;: 3, &quot;gutter&quot;: 24, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1,&quot;nav&quot;:true},&quot;500&quot;:{&quot;items&quot;:2},&quot;850&quot;:{&quot;items&quot;:3},&quot;1400&quot;:{&quot;items&quot;:3,&quot;nav&quot;:false}}}">
            <!-- Item-->
            <c:forEach var="place" items="${placeList }">
            <article>
            <c:forTokens var="photo" items="${place.place_photo}" delims="," begin="0" end="0">
            <a class="d-block rounded-3 overflow-hidden" href="placeDetail?place_id=${place.place_id}&page=1&state=cont"><img class="d-block" src="<%=request.getContextPath()%>/upload/${photo}" alt="Image"></a>
            </c:forTokens>
              <div class="py-3"><a class="fs-xs text-uppercase text-decoration-none" href="#">${place.place_act}</a>
                <h3 class="fs-base pt-1"><a class="nav-link" href="placeDetail?place_id=${place.place_id}&page=1&state=cont">${place.place_name}</a></h3>
                  <div class="ps-2">
                    <h6 class="fs-sm lh-base mb-1"><i class="fi-map-pin me-1"></i>${place.place_addr}</h6>
                    <div class="d-flex fs-xs opacity-60"><span class="me-2 pe-1"><i class="fi-alarm me-1"></i>${place.place_hour}</span><span><i class="fi-star me-1"></i>${place.place_rate}</span></div>
                  </div>
              </div>
            </article>
            </c:forEach>
          </div>
        </div>
      </section>
      
      <!-- 식당 -->
      <section class="container mb-sm-5 mb-4 pb-lg-4">
        <div class="d-sm-flex align-items-center justify-content-between mb-4 pb-2">
          <h2 class="h3 mb-sm-0">식당</h2><a class="btn btn-link fw-normal ms-sm-3 p-0" href="foodList">더보기<i class="fi-arrow-long-right ms-2"></i></a>
        </div>
        <!-- Carousel-->
        <div class="tns-carousel-wrapper tns-nav-outside tns-nav-outside-flush mx-n2">
          <div class="tns-carousel-inner row gx-4 mx-0" data-carousel-options="{&quot;nav&quot;: false, &quot;autoHeight&quot;: true, &quot;controlsContainer&quot;: &quot;#carousel-controls-tp&quot;, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;1320&quot;:{&quot;items&quot;:2}}}">
            <!-- Carousel item-->
            <c:set var="food" value="${foodList }"/>
            <div class="col">
              <div class="row gy-md-0 gy-sm-4 gy-3 gx-sm-4 gx-0">
              <c:forTokens var="photo" items="${food[0].food_photo}" delims="," begin="0" end="0">
                <div class="col-md-7">
                <a class="text-decoration-none text-light card bg-size-cover bg-position-center border-0 overflow-hidden h-100" href="real-estate-single-v1.html" style="background-image: url(upload/${photo}); min-height: 18.75rem;"><span class="img-gradient-overlay"></span>
                    <div class="card-body content-overlay pb-0"></div>
                    <div class="card-footer content-overlay border-0 pt-0 pb-4">
                      <div class="d-sm-flex justify-content-between align-items-end pt-5 mt-2 mt-sm-5">
                        <div class="pe-2">
                          <div class="fs-sm text-uppercase pt-2 mb-1">${food[0].food_feat}</div>
                          <h3 class="h5 text-light mb-1">${food[0].food_name}</h3>
                          <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[0].food_addr}</div>
                        </div>
                      </div>
                    </div></a></div>
                    </c:forTokens>
                    
                <div class="col-md-5"><a class="card border-0 overflow-hidden mb-sm-4 mb-3 text-decoration-none text-light" href="real-estate-single-v2.html">
                    <c:forTokens var="photo" items="${food[1].food_photo}" delims="," begin="0" end="0">
                    <div class="card-body p-0 position-relative"><img src="upload/${photo}" alt="Article image"><span class="img-gradient-overlay zindex-1"></span>
                      <div class="position-absolute start-0 bottom-0 m-n1 p-4 zindex-5">
                        <div class="fs-sm text-uppercase pt-2 mb-1">${food[1].food_feat}</div>
                        <h3 class="h5 text-light mb-1">${food[1].food_name}</h3>
                        <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[1].food_addr}</div>
                      </div></c:forTokens>
                    </div></a><a class="card border-0 overflow-hidden text-decoration-none text-light" href="real-estate-single-v2.html">
                    <c:forTokens var="photo" items="${food[2].food_photo}" delims="," begin="0" end="0">
                    <div class="card-body p-0 position-relative"><img src="upload/${photo}" alt="Article image"><span class="img-gradient-overlay zindex-1"></span>
                      <div class="position-absolute start-0 bottom-0 m-n1 p-4 zindex-5">
                        <div class="fs-sm text-uppercase pt-2 mb-1">${food[2].food_feat}</div>
                        <h3 class="h5 text-light mb-1">${food[2].food_name}</h3>
                        <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[2].food_addr}</div>
                      </div>
                    </div></c:forTokens></a></div>
                     
              </div>
            </div>
            <!-- Carousel item-->
            <div class="col">
              <div class="row gy-md-0 gy-sm-4 gy-3 gx-sm-4 gx-0">
               <c:forTokens var="photo" items="${food[3].food_photo}" delims="," begin="0" end="0">
                <div class="col-md-7"><a class="text-decoration-none text-light card bg-size-cover bg-position-center border-0 overflow-hidden h-100" href="real-estate-single-v1.html" style="background-image: url(upload/${photo}); min-height: 18.75rem;"><span class="img-gradient-overlay"></span>
                    <div class="card-body content-overlay pb-0"></div>
                    <div class="card-footer content-overlay border-0 pt-0 pb-4">
                      <div class="d-sm-flex justify-content-between align-items-end pt-5 mt-2 mt-sm-5">
                        <div class="pe-2">
                          <div class="fs-sm text-uppercase pt-2 mb-1">${food[3].food_feat}</div>
                          <h3 class="h5 text-light mb-1">${food[3].food_name}</h3>
                          <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[3].food_addr}</div>
                        </div>
                      </div>
                    </div></a></div></c:forTokens>
                   
                <div class="col-md-5"><a class="card border-0 overflow-hidden mb-sm-4 mb-3 text-decoration-none text-light" href="real-estate-single-v2.html">
                     <c:forTokens var="photo" items="${food[4].food_photo}" delims="," begin="0" end="0">
                    <div class="card-body p-0 position-relative"><img src="upload/${photo}" alt="Article image"><span class="img-gradient-overlay zindex-1"></span>
                      <div class="position-absolute start-0 bottom-0 m-n1 p-4 zindex-5">
                        <div class="fs-sm text-uppercase pt-2 mb-1">${food[4].food_feat}</div>
                        <h3 class="h5 text-light mb-1">${food[4].food_name}</h3>
                        <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[4].food_addr}</div>
                      </div>
                    </div></c:forTokens></a><a class="card border-0 overflow-hidden text-decoration-none text-light" href="real-estate-single-v2.html">
                    <c:forTokens var="photo" items="${food[5].food_photo}" delims="," begin="0" end="0">
                    <div class="card-body p-0 position-relative"><img src="upload/${photo}" alt="Article image"><span class="img-gradient-overlay zindex-1"></span>
                      <div class="position-absolute start-0 bottom-0 m-n1 p-4 zindex-5">
                        <div class="fs-sm text-uppercase pt-2 mb-1">${food[5].food_feat}</div>
                        <h3 class="h5 text-light mb-1">${food[5].food_name}</h3>
                        <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[5].food_addr}</div>
                      </div>
                    </div></c:forTokens></a></div>
              </div>
            </div>
            <!-- Carousel item-->
            <div class="col">
              <div class="row gy-md-0 gy-sm-4 gy-3 gx-sm-4 gx-0">
              <c:forTokens var="photo" items="${food[6].food_photo}" delims="," begin="0" end="0">
                <div class="col-md-7"><a class="text-decoration-none text-light card bg-size-cover bg-position-center border-0 overflow-hidden h-100" href="real-estate-single-v1.html" style="background-image: url(upload/${photo}); min-height: 18.75rem;"><span class="img-gradient-overlay"></span>
                    <div class="card-body content-overlay pb-0"></div>
                    <div class="card-footer content-overlay border-0 pt-0 pb-4">
                      <div class="d-sm-flex justify-content-between align-items-end pt-5 mt-2 mt-sm-5">
                        <div class="pe-2">
                          <div class="fs-sm text-uppercase pt-2 mb-1">${food[6].food_feat}</div>
                          <h3 class="h5 text-light mb-1">${food[6].food_name}</h3>
                          <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[6].food_addr}</div>
                        </div>
                      </div>
                    </div></a></div></c:forTokens>
                <div class="col-md-5"><a class="card border-0 overflow-hidden mb-sm-4 mb-3 text-decoration-none text-light" href="real-estate-single-v2.html">
                    <c:forTokens var="photo" items="${food[7].food_photo}" delims="," begin="0" end="0">
                    <div class="card-body p-0 position-relative"><img src="upload/${photo}" alt="Article image"><span class="img-gradient-overlay zindex-1"></span>
                      <div class="position-absolute start-0 bottom-0 m-n1 p-4 zindex-5">
                        <div class="fs-sm text-uppercase pt-2 mb-1">${food[7].food_feat}</div>
                        <h3 class="h5 text-light mb-1">${food[7].food_name}</h3>
                        <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[7].food_addr}</div>
                      </div>
                    </div></c:forTokens></a><a class="card border-0 overflow-hidden text-decoration-none text-light" href="real-estate-single-v2.html">
                    <c:forTokens var="photo" items="${food[8].food_photo}" delims="," begin="0" end="0">
                    <div class="card-body p-0 position-relative"><img src="upload/${photo}" alt="Article image"><span class="img-gradient-overlay zindex-1"></span>
                      <div class="position-absolute start-0 bottom-0 m-n1 p-4 zindex-5">
                        <div class="fs-sm text-uppercase pt-2 mb-1">${food[8].food_feat}</div>
                        <h3 class="h5 text-light mb-1">${food[8].food_name}</h3>
                        <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[8].food_addr}</div>
                      </div>
                    </div></c:forTokens></a></div>
              </div>
            </div>
             <!-- Carousel item-->
            <div class="col">
              <div class="row gy-md-0 gy-sm-4 gy-3 gx-sm-4 gx-0">
               <c:forTokens var="photo" items="${food[9].food_photo}" delims="," begin="0" end="0">
                <div class="col-md-7"><a class="text-decoration-none text-light card bg-size-cover bg-position-center border-0 overflow-hidden h-100" href="real-estate-single-v1.html" style="background-image: url(upload/${photo}); min-height: 18.75rem;"><span class="img-gradient-overlay"></span>
                    <div class="card-body content-overlay pb-0"></div>
                    <div class="card-footer content-overlay border-0 pt-0 pb-4">
                      <div class="d-sm-flex justify-content-between align-items-end pt-5 mt-2 mt-sm-5">
                        <div class="pe-2">
                          <div class="fs-sm text-uppercase pt-2 mb-1">${food[9].food_feat}</div>
                          <h3 class="h5 text-light mb-1">${food[9].food_name}</h3>
                          <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[9].food_addr}</div>
                        </div>
                      </div>
                    </div></a></div></c:forTokens>
                <div class="col-md-5"><a class="card border-0 overflow-hidden mb-sm-4 mb-3 text-decoration-none text-light" href="real-estate-single-v2.html">
                    <c:forTokens var="photo" items="${food[10].food_photo}" delims="," begin="0" end="0">
                    <div class="card-body p-0 position-relative"><img src="upload/${photo}" alt="Article image"><span class="img-gradient-overlay zindex-1"></span>
                      <div class="position-absolute start-0 bottom-0 m-n1 p-4 zindex-5">
                        <div class="fs-sm text-uppercase pt-2 mb-1">${food[10].food_feat}</div>
                        <h3 class="h5 text-light mb-1">${food[10].food_name}</h3>
                        <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[10].food_addr}</div>
                      </div>
                    </div></c:forTokens></a><a class="card border-0 overflow-hidden text-decoration-none text-light" href="real-estate-single-v2.html">
                    <c:forTokens var="photo" items="${food[11].food_photo}" delims="," begin="0" end="0">
                    <div class="card-body p-0 position-relative"><img src="upload/${photo}" alt="Article image"><span class="img-gradient-overlay zindex-1"></span>
                      <div class="position-absolute start-0 bottom-0 m-n1 p-4 zindex-5">
                        <div class="fs-sm text-uppercase pt-2 mb-1">${food[11].food_feat}</div>
                        <h3 class="h5 text-light mb-1">${food[11].food_name}</h3>
                        <div class="fs-sm opacity-70"><i class="fi-map-pin me-1"></i>${food[11].food_addr}</div>
                      </div>
                    </div></c:forTokens></a></div>
              </div>
            </div>
          </div>
        </div>
        <!-- Carousel custom controls-->
        <div class="tns-carousel-controls justify-content-center pt-md-2 mt-4" id="carousel-controls-tp">
          <button class="me-3" type="button" aria-controls="tns2"><i class="fi-chevron-left fs-xs"></i></button>
          <button type="button" aria-controls="tns2"><i class="fi-chevron-right fs-xs"></i></button>
        </div>
      </section>
 
      <!-- 숙소 -->
      <section class="container mb-5 pb-md-4">
        <div class="d-flex align-items-center justify-content-between mb-3">
          <h2 class="h3 mb-0">숙소</h2><a class="btn btn-link fw-normal p-0" href="roomList">더보기<i class="fi-arrow-long-right ms-2"></i></a>
        </div>
        <div class="tns-carousel-wrapper tns-controls-outside-xxl tns-nav-outside tns-nav-outside-flush mx-n2">
          <div class="tns-carousel-inner row gx-4 mx-0 pt-3 pb-4" data-carousel-options="{&quot;items&quot;: 4, &quot;responsive&quot;: {&quot;0&quot;:{&quot;items&quot;:1},&quot;500&quot;:{&quot;items&quot;:2},&quot;768&quot;:{&quot;items&quot;:3},&quot;992&quot;:{&quot;items&quot;:4}}}">
            <!-- Item-->
            <c:forEach var="room" items="${roomList }">
            <div class="col">
              <div class="card shadow-sm card-hover border-0 h-100">
                <div class="card-img-top card-img-hover"><a class="img-overlay" href="real-estate-single-v1.html"></a>
                  <div class="position-absolute start-0 top-0 pt-3 ps-3"><span class="d-table badge bg-success mb-1">Verified</span><span class="d-table badge bg-info">New</span></div>
                  <div class="content-overlay end-0 top-0 pt-3 pe-3">
                    <button class="btn btn-icon btn-light btn-xs text-primary rounded-circle" type="button" data-bs-toggle="tooltip" data-bs-placement="left" title="Add to Wishlist"><i class="fi-heart"></i></button>
                  </div>
                  <c:forTokens var="photo" items="${room.room_photo}" delims="," begin="0" end="0">
                  <img src="<%=request.getContextPath()%>/upload/${photo}" alt="Image">
                  </c:forTokens>
                </div>
                <div class="card-body position-relative pb-3">
                  <h4 class="mb-1 fs-xs fw-normal text-uppercase text-primary">${room.room_type }</h4>
                  <h3 class="h6 mb-2 fs-base"><a class="nav-link stretched-link" href="real-estate-single-v1.html">${room.room_name }</a></h3>
                  <p class="mb-2 fs-sm text-muted">${room.room_addr }</p>
                  <div class="fw-bold"><i class="fi-cash mt-n1 me-2 lead align-middle opacity-70"></i>₩ ${room.room_cost }</div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-center mx-3 pt-3 text-nowrap"><span class="d-inline-block mx-1 px-2 fs-sm"><i class="fi-info-circle ms-1 mt-n1 fs-lg text-muted"></i>&nbsp;${room.room_option }</span></div>
              </div>
            </div>
            </c:forEach>
          </div>
        </div>
      </section>

    <!-- Footer-->
    <%@ include file="footer.jsp" %>
    <!-- Back to top button--><a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon fi-chevron-up">   </i></a>
    <!-- Vendor scrits: js libraries and plugins-->
    <script src="vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/simplebar/dist/simplebar.min.js"></script>
    <script src="vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
    <script src="vendor/tiny-slider/dist/min/tiny-slider.js"></script>
    <script src="vendor/flatpickr/dist/flatpickr.min.js"></script>
    <!-- Main theme script-->
    <script src="js/theme.min.js"></script>
  </body>
</html>