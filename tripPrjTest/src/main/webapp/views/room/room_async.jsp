<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>

       <script src="http://code.jquery.com/jquery-latest.js"></script>
       <script type="text/javascript">
	       	function roomFilterPage(page) {
		   		alert($('#roomForm').serialize());
		   		alert(page);
		   		
		   		event.preventDefault();
		   		$.ajax({
		   				url : 'roomFilterPage?page='+ page,
		   				type : 'post',
		   				data : $('#roomForm').serializeArray(),
		   				success : function(data) {
		   					$('#roomAsync').html(data);
		   				}				
		   		});
	   		};
       </script>
       	
	   <div class="map-popup invisible" id="map">
	     <button class="btn btn-icon btn-light btn-sm shadow-sm rounded-circle" type="button" data-bs-toggle-class="invisible" data-bs-target="#map"><i class="fi-x fs-xs"></i></button>
	     <div class="interactive-map" data-map-options-json="json/map-options-city-guide.json"></div>
	   </div>
	   <!-- Breadcrumb-->
	   <nav class="mb-3 pt-md-2" aria-label="Breadcrumb">
	     <ol class="breadcrumb">
	       <li class="breadcrumb-item"><a href="city-guide-home-v1.html">Home</a></li>
	       <li class="breadcrumb-item active" aria-current="page">숙소</li>
	     </ol>
	   </nav>
	   <!-- Title-->
	   <div class="d-sm-flex align-items-center justify-content-between pb-3 pb-sm-4">
	     <h1 class="h2 mb-sm-0">숙소</h1>
	   </div>
	   <!-- Sorting-->
	   <div class="d-flex flex-sm-row flex-column align-items-sm-center align-items-stretch my-2">
	     <div class="d-flex align-items-center flex-shrink-0">
	       <label class="fs-sm me-2 pe-1 text-nowrap" for="sortby"><i class="fi-arrows-sort text-muted mt-n1 me-2"></i>Sort by:</label>
	       <select class="form-select form-select-sm" id="sortby">
	         <option>Newest</option>
	         <option>Popularity</option>
	         <option>Low - High Price</option>
	         <option>High - Low Price</option>
	         <option>High rating</option>
	         <option>Average Rating</option>
	       </select>
	     </div>
	     <hr class="d-none d-sm-block w-100 mx-4">
	     <div class="d-none d-sm-flex align-items-center flex-shrink-0 text-muted"><i class="fi-check-circle me-2"></i><span class="fs-sm mt-n1">${listCount } results</span></div>
	   </div>
	
	   <!-- Catalog grid-->           
	   <div class="row g-4 py-4">     
	   <!-- Item-->
	   <c:if test="${empty roomList }">
	   <div class="d-sm-flex align-items-center justify-content-between pb-3 pb-sm-4">
	     <h1 class="h2 mb-sm-0">검색결과가 존재하지 않습니다.</h1>
	   </div>
	   </c:if>
	   <c:forEach var="room" items="${roomList }">
	       <div class="col-sm-6 col-xl-4">
	         <div class="card shadow-sm card-hover border-0 h-100">
	           <div class="tns-carousel-wrapper card-img-top card-img-hover"><a class="img-overlay" href="roomDetail?room_id=${room.room_id}&page=${page}&state=cont"></a>
	             <div class="position-absolute start-0 top-0 pt-3 ps-3"></div>
	             <div class="content-overlay end-0 top-0 pt-3 pe-3">
	               <button class="btn btn-icon btn-light btn-xs text-primary rounded-circle" type="button" data-bs-toggle="tooltip" data-bs-placement="left" title="Add to Wishlist"><i class="fi-heart"></i></button>
	             </div>
	             <c:forTokens var="photo" items="${room.room_photo}" delims="," begin="0" end="0">
	               <div class="tns-carousel"><img src="<%=request.getContextPath()%>/upload/${photo}" alt="Image"/></div>
	             </c:forTokens>
	           </div>
	           <div class="card-body position-relative pb-3">
	             <h4 class="mb-1 fs-xs fw-normal text-uppercase text-primary">${room.room_type }</h4>
	             <h3 class="h6 mb-2 fs-base"><a class="nav-link stretched-link" href="real-estate-single-v1.html">${room.room_name }</a></h3>
	             <p class="mb-2 fs-sm text-muted">${room.room_addr }</p>
	             <div class="fw-bold"><i class="fi-cash mt-n1 me-2 lead align-middle opacity-70"></i>${room.room_cost }</div>
	           </div>
	           <div class="card-footer d-flex align-items-center justify-content-center mx-3 pt-3 text-nowrap"><span class="d-inline-block mx-1 px-2 fs-sm"><i class="fi-info-circle ms-1 mt-n1 fs-lg text-muted"></i>&nbsp;${room.room_option }</span></div>
	         </div>
	       </div>
       </c:forEach>
	 </div>
	   
	 <!-- Pagination-->
	 <c:if test="${listCount > 0 }">
	 <nav class="border-top pb-md-4 pt-4 mt-2" aria-label="Pagination" id="pagination">
	   <ul class="pagination mb-1">
	     <li class="page-item d-sm-none"><span class="page-link page-link-static">1 / 10</span></li>
	     
		 <!-- 이전 블럭 -->
	     <c:if test="${startPage > 10 }">
	     <li class="page-item"><a class="page-link" href="roomList?page=${startPage-10 }" aria-label="Next"><i class="fi-chevron-left"></i></a></li>
	     </c:if>
	     
	     <!-- 1 페이지 -->
	     <c:if test="${page != 1 && startPage != 1}">
	     <li class="page-item d-none d-sm-block"><a class="page-link" href="roomList?page=1" aria-label="Previous"><i class="fi-chevron-left"></i></a></li>
	     <li class="page-item d-none d-sm-block">...</li>
	     </c:if>
	     
	     <!-- 블럭 당 페이지 출력 -->
	     <c:forEach var="i" begin="${startPage }" end="${endPage }">
	     <c:if test="${i == page }">
	     <li class="page-item active d-none d-sm-block" aria-current="page"><span class="page-link">${i}<span class="visually-hidden">(current)</span></span></li>
	     </c:if>
	     <c:if test="${i != page}">
	     <li class="page-item d-none d-sm-block"><a class="page-link" onclick="roomFilterPage(${i})">${i}</a></li>
	     </c:if>
	     </c:forEach>
	     <%-- href="roomFilter?page=${i}" --%>
	     
	     <!-- 마지막 페이지 -->
	     <c:if test="${endPage != pageCount}">
	     <li class="page-item d-none d-sm-block">...</li>
	     <li class="page-item d-none d-sm-block"><a class="page-link" href="roomList?page=${pageCount}">${pageCount}</a></li>
	     </c:if>
	     
	     <!-- 다음 블럭 -->
	     <c:if test="${endPage < pageCount}">
	     <li class="page-item"><a class="page-link" href="roomList?page=${startPage+10 }" aria-label="Next"><i class="fi-chevron-right"></i></a></li>
	     </c:if>
	     
	   </ul>
	 </nav>
	 </c:if>

