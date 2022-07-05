<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>Finder | Real Estate | Single Property v.1</title>
   
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
   <link rel="stylesheet" type="text/css" href="bbs.css" />
   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/bbss.css" />
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
    
<script src="webjars/jquery/dist/jquery.min.js"></script>
<script type="text/javascript">



/* $(function replyList(){

	 $('#').click(function(){
		 alert(form);
		 $('##seeMoreOverviews').load('modal');
		 
	 }); 
 }); */
 
function modify(food_rev_id){
	 $('#modifyform').load('foodReviewModifyModal?food_rev_id='+food_rev_id);
 }
 

function writes(food_id){
	 $('#writeform').load('foodReviewWriteModal?food_id='+food_id);
 }
 
 function reply(food_rev_id){
	 $('#replyform').load('foodReplyWriteModal?food_rev_id='+food_rev_id);
 }


function replyList(food_rev_id){
	 
	 $('#seeMoreOverview_'+food_rev_id).load('foodReplyList?food_rev_id='+food_rev_id);
	
	
	
	/* alert(food_rev_id);

	$.ajax({
		url : '${path}/foodReplyList',
		type : 'post',
		data : food_rev_id,
		success : function(data){
			
		}
		
	}); */
	
	
	
/* 	$.post("/foodReplyList"),
		  {food_rev_id : "food_rev_id"}, 
		  function(food_rev_id){
			alert("food_rev_id="+food_rev_id);
	};  */
	
 };
 
 

/* function replyLists(food_rev_id){
	event.preventDefault();
	$.ajax({
		url : 'foodReplyLists?food_rev_id='+food_rev_id', 
		type : 'post',
		success : function(data) {
			$('#replylists').html(data);
		}
		
	});
	
}; */


/* function del(food_rev_id,food_id) {			
	var formData="food_rev_id="+food_rev_id+"&food_id="+food_id;
	$.post("foodReviewDetail",formData, function(data) {
		href="#modal-review-modify"
	});
} */


/* $(function() {
    	
   	
    	document.querySelector('#reviewFormValue').addEventListener('submit', function(event){
    		
    		event.preventDefault();
    		
    		
    		var starNodeList = event.currentTarget.querySelectorAll('input');
    		var starInputList = Array.from(starNodeList); 
    		var starValue = starInputList.find(inputEl => inputEl.checked).value;
    		//var formValues = $('#reviewFormValue').serialize();
    		
    		
	        
	        var formData = new FormData(); 
	        
	        var fileInput = $('.filse');
	     	for (var i = 0; i < fileInput.length; i++) {
	     	if (fileInput[i].files.length > 0) {
	     		for (var j = 0; j < fileInput[i].files.length; j++) {
	     			/* console.log(" fileInput[i].files[j] :::"+ fileInput[i].files[j]); */
	     			
	     		/* 	formData.append('rev_photos', $('.files')[i].files[j]);
	     		}
	     	}
	     }
	        

			formData.append("rev_content",rev_content);
			formData.append("starValue",starValue);
	        
    		console.log(formData);
    		console.log(starValue); */
    		
    	/* 	 $.post('reviewWrite', formValues, function(data) {
				console.log(data);
			}); */ 
    		
    		/*  $.ajax({
    			type: "post",
    			url: "reviewWrite",
    			data: formData,
    			enctype : 'multipart/form-data',
    			processData: false,
    			contentType: false


    			}); 

    		
    	});   	
    	
    	
    }); */
    
    
    
/*     $(function(){
    	$('#needs-validation').onChange(function(){
    		
    		alert('submit이벤트발생');
    			var files = target.files;
    	 	
    		//파일 배열 담기
    		var filesArr = Array.prototype.slice.call(files);
    		
    		if(fileCount + filesArr.length > totalCount){
    			alert("파일은 최대 "+totalCount+"개까지 업로드 할 수 있습니다.");
    			$("#rev_photo").val(""); 
    			return false;
    		}
    		
    	});
    	
    }); */
    
    </script>
    
<!--     <script>    
    var totalCount = 5;
    
	function fileChange(target){
		 
		var files = target.files;
		
		//파일 배열 담기
		var filesArr = Array.prototype.slice.call(files);
		
		if(fileCount + filesArr.length > totalCount){
			alert("파일은 최대 "+totalCount+"개까지 업로드 할 수 있습니다.");
			$("#rev_photo").val(""); 
			return false;
		}

	    	
	    
	}
	 </script> -->

    
    <!-- Vendor Styles-->
    <link rel="stylesheet" media="screen" href="vendor/simplebar/dist/simplebar.min.css"/>
    <link rel="stylesheet" media="screen" href="vendor/lightgallery/css/lightgallery-bundle.min.css"/>
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
     
      <!-- Page content-->
      <!-- Review modal-->
      <div class="modal fade" id="modal-review" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header d-block position-relative border-0 pb-0 px-sm-5 px-4">
              <h3 class="modal-title mt-4 text-center">리뷰를 남겨주세요</h3>
              <button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
    
            <div class="modal-body px-sm-5 px-4" id="writeform">
	<!-- 리뷰 작성폼 -->
	<!-- load함수로 불러옴 -->
            </div>
          </div>
        </div>
      </div>
      
      
      
      
      
<!-------------- 리뷰 수정 -------------------->
    <div class="modal fade" id="modal-review-modify" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header d-block position-relative border-0 pb-0 px-sm-5 px-4">
              <h3 class="modal-title mt-4 text-center">리뷰를 남겨주세요</h3>
              <button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
    
            <div class="modal-body px-sm-5 px-4" id="modifyform">
            
            
	<!-- 리뷰 수정폼 -->	
	<!-- load함수로 불러옴 -->	
            </div>
          </div>
        </div>
      </div>
      
      
      
      
      
      
<!-------------------- 댓글 작성 ------------------------------->
      <div class="modal fade" id="modal-reply" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered" role="document" id="replyform">
			<!-- 댓글 작성폼 modal을 load로 불러옴 -->
        </div>
      </div>
      
      <!-- 댓글 수정 -->
       <div class="modal fade" id="modal-reply-modify" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header d-block position-relative border-0 pb-0 px-sm-5 px-4">
              <h3 class="modal-title mt-4 text-center">댓글을 남겨주세요</h3>
              <button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-sm-5 px-4">
              <form class="needs-validation" method="post" enctype="multipart/form-data">
              <input type="hidden" name="id" id="id" value="${sessionScope.id }">
                <div class="mb-4">
                  <label class="form-label" for="review-text">댓글 <span class='text-danger'>*</span></label>
                  <textarea class="form-control" name=""  rows="5" placeholder="댓글 내용" required></textarea>
                  <div class="invalid-feedback">댓글을 작성해주세요.</div>
                </div>
                <div class="mb-4">
                  <input class="form-control" type="file" name="" id="" multiple="multiple">
                </div>
                <button class="btn btn-primary d-block w-100 mb-4" type="submit">글쓰기</button>
              </form>
            </div>
          </div>
        </div>
      </div>
      
      <!-- Page header-->
      <section class="container pt-5 mt-5">
      </section>
      <!-- Post content-->
      <section class="container mb-5 pb-1">
        <div class="row">
          <div class="col-md-7 mb-md-0 mb-4">
            
            <!-- Reviews-->
            <div class="mb-4 pb-4 border-bottom">
              <h3 class="h4 pb-3"><i class="fi-star-filled mt-n1 me-2 lead align-middle text-warning"></i> (32 reviews)</h3>
              <div class="d-flex flex-sm-row flex-column align-items-sm-center align-items-stretch justify-content-between">
              <button class="btn btn-outline-primary mb-sm-0 mb-3" href="#modal-review" data-bs-toggle="modal" onclick="writes(${food_id})">
              <i class="fi-edit me-1"></i>Add review</button>
                <div class="d-flex align-items-center ms-sm-4">
                  <label class="me-2 pe-1 text-nowrap" for="reviews-sorting"><i class="fi-arrows-sort text-muted mt-n1 me-2"></i>Sort by:</label>
                  <select class="form-select" id="reviews-sorting">
                    <option>Newest</option>
                    <option>Oldest</option>
                    <option>Popular</option>
                    <option>High rating</option>
                    <option>Low rating</option>
                  </select>
                </div>
              </div>
            </div>
            
<!----------------------- Review list	----------------------->
			<c:forEach var="foodReview" items="${foodReviewList}">
				
				
	            <div class="mb-4 pb-4 border-bottom">
	            
	              <div class="d-flex justify-content-between mb-3">
	                <div class="d-flex align-items-center pe-2"><img class="rounded-circle me-1" src="img/avatars/16.png" width="48" alt="Avatar">
	                  <div class="ps-2">
	                  <div class="starpoint_wraps">
					 	<div class="starpoint_boxs" id="star1">
					 	${foodReviewStar }
					 	<c:forEach var="i" begin="1" end="10">
					 		<input type="radio" name="starpoint" id="starpoint_${i}" class="star_radio" value="${i/2}"   > 
 					    	<label for="starpoint_${i}"  class="label_star" title="${i/2}"><span class="blind">${i/2}점</span></label> 
 					    </c:forEach>	
					   		<span class="starpoint_bg" style="width: ${foodReview.rev_rate * 2 * 10}% !important"></span>
					  	</div>
						</div>
	                  		
	                    <h6 class="fs-base mb-0">${foodReview.id}</h6> </div>
	                </div><span class="text-muted fs-sm">${foodReview.rev_reg}</span>
	              </div>
	              <p>${foodReview.rev_content}</p>
	              <div class="fs-base mb-0">
	              <c:forTokens var="photo" items="${foodReview.rev_photo}" delims=",">
						<img src="<%=request.getContextPath()%>/upload/${photo}" height="100" width="100"/>
				  </c:forTokens>
					</div>
					
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="d-flex align-items-center pe-2"><button class="btn-like" type="button"><i class="fi-heart"></i><span>(3)</span></button>
	                </div>
	                <button class="btn btn-link btn-sm" type="button" href="#modal-reply" data-bs-toggle="modal"
	                onclick="reply(${foodReview.food_rev_id })">
	                <i class="fi-reply fs-lg me-2"></i><span class="fw-normal">댓글</span></button>
	              </div>
	              
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="d-flex align-items-center pe-2"></div>
	                <button class="btn btn-link btn-sm" type="button"  id="test1"  href="#modal-review-modify"  data-bs-toggle="modal" value="${foodReview.food_rev_id }" onclick="modify(${foodReview.food_rev_id })">
	  			      <i class="fi-reply fs-lg me-2"></i><span class="fw-normal">수정</span></button>
	    
	              </div>
	              
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="d-flex align-items-center pe-2"></div>
	                 <button type="button" value="삭제" class="btn btn-link btn-sm" onclick="location='foodReviewDelete?food_rev_id=${foodReview.food_rev_id}'" >
	                <i class="fi-reply fs-lg me-2"></i><span class="fw-normal">삭제</span></button>     
	              </div>
	              <a class="collapse-label collapsed" href="#seeMoreOverview_${foodReview.food_rev_id}" data-bs-toggle="collapse" data-bs-label-collapsed="댓글 보기" data-bs-label-expanded="접기" role="button" aria-expanded="false" aria-controls="seeMoreOverview" 
                  	onclick="replyList(${foodReview.food_rev_id })"></a>
                 
	                
	               
	                
              <!-- Reply to comment-->
              <div class="collapse" id="seeMoreOverview_${foodReview.food_rev_id}">
    		  <!-- load메소드로 댓글 리스트 불러오는 영역 -->
              </div>
              
    		  </div>
              </c:forEach>        
              </div>          
            </div>

            <!-- Pagination-->
            <nav class="mt-2 mb-4" aria-label="Reviews pagination">
              <ul class="pagination">
                <li class="page-item d-sm-none"><span class="page-link page-link-static">1 / 5</span></li>
                
             
                
                <c:forEach var="a" begin="${startPage}" end="${endPage}">
                	<c:if test="${a == page }">
                		<li class="page-item active d-none d-sm-block" aria-current="page"><span class="page-link">${a}<span class="visually-hidden">(current)</span></span></li>
					</c:if>
					<c:if test="${a != page }">
						<li class="page-item d-none d-sm-block"><a class="page-link" href="foodReviewList?page=${a}"><span class="page-link">${a}<span class="visually-hidden"></span></span></a></li>
					</c:if>
                </c:forEach>
                
                <li class="page-item"><a class="page-link" href="#" aria-label="Next"><i class="fi-chevron-right"></i></a></li>
              </ul>
            </nav>
            		

      </section>
    </main>
    <!-- Footer-->
    <footer class="footer bg-secondary pt-5">
      <div class="container pt-lg-4 pb-4">

        <div class="text-center fs-sm pt-4 mt-3 pb-2">&copy; All rights reserved. Made by <a href='https://createx.studio/' class='d-inline-block nav-link p-0' target='_blank' rel='noopener'>Createx Studio</a></div>
      </div>
    </footer>
    <a class="btn-scroll-top" href="#top" data-scroll><span class="btn-scroll-top-tooltip text-muted fs-sm me-2">Top</span><i class="btn-scroll-top-icon fi-chevron-up">   </i></a>

    <script src="vendor/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="vendor/simplebar/dist/simplebar.min.js"></script>
    <script src="vendor/smooth-scroll/dist/smooth-scroll.polyfills.min.js"></script>
    <script src="vendor/lightgallery/lightgallery.min.js"></script>
    <script src="vendor/lightgallery/plugins/fullscreen/lg-fullscreen.min.js"></script>
    <script src="vendor/lightgallery/plugins/zoom/lg-zoom.min.js"></script>
    <script src="vendor/lightgallery/plugins/thumbnail/lg-thumbnail.min.js"></script>
    <script src="vendor/flatpickr/dist/flatpickr.min.js"></script>
    <script src="vendor/tiny-slider/dist/min/tiny-slider.js"></script>
    <!-- Main theme script-->
    <script src="js/theme.min.js"></script>
  </body>
</html>