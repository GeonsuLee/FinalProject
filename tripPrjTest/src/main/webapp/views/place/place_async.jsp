<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>

       <script src="http://code.jquery.com/jquery-latest.js"></script>
       <script type="text/javascript">
	       	function placeFilterPage(page) {
		   		alert($('#placeForm').serialize());
		   		alert(page);
		   		
		   		event.preventDefault();
		   		$.ajax({
		   				url : 'placeFilterPage?page='+ page,
		   				type : 'post',
		   				data : $('#placeForm').serializeArray(),
		   				success : function(data) {
		   					$('#placeAsync').html(data);
		   				}				
		   		});
	   		};
       </script>
       	
	   <div class="map-popup invisible" id="map">
              <button class="btn btn-icon btn-light btn-sm shadow-sm rounded-circle" type="button" data-bs-toggle-class="invisible" data-bs-target="#map"><i class="fi-x fs-xs"></i></button>
              <div class="interactive-map" data-map-options-json="json/map-options-real-estate-rent.json"></div>
            </div>
            <!-- Breadcrumb-->
            <nav class="mb-3 pt-md-2" aria-label="Breadcrumb">
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="main">Home</a></li>
                <li class="breadcrumb-item active" aria-current="page">명소</li>
              </ol>
            </nav>
            <!-- Title-->
            <div class="d-sm-flex align-items-center justify-content-between pb-3 pb-sm-4">
              <h1 class="h2 mb-sm-0">명소</h1>
            </div>
            <!-- Sorting-->
            <div class="d-flex flex-sm-row flex-column align-items-sm-center align-items-stretch my-2">
              <hr class="d-none d-sm-block w-100 mx-4">
              <div class="d-none d-sm-flex align-items-center flex-shrink-0 text-muted"><i class="fi-check-circle me-2"></i><span class="fs-sm mt-n1">${listCount } results</span></div>
            </div>
            <!-- Articles list-->
          <div class="col-lg-12">
            <!-- Catalog grid-->
            <div class="row g-4 py-4">
            <c:if test="${empty placeList }">
			   <div class="d-sm-flex align-items-center justify-content-between pb-3 pb-sm-4">
			     <h1 class="h2 mb-sm-0">검색결과가 존재하지 않습니다.</h1>
			   </div>
		    </c:if>
            <!-- Article-->
            <c:forEach var="place" items="${placeList }">
              <article class="card card-horizontal border-0 mb-4"><a class="card-img-top position-relative rounded-3 me-sm-4 mb-sm-0 mb-3" href="placeDetail?place_id=${place.place_id}&page=${page}&state=cont">
                <c:forTokens var="photo" items="${place.place_photo}" delims="," begin="0" end="0">
                    <div><img class="rounded-3" src="<%=request.getContextPath()%>/upload/${photo}" alt="Image"/></div>
                 </c:forTokens><span class="badge bg-info position-absolute top-0 end-0 m-3 fs-sm">New</span></a>
                <div class="card-body px-0 pt-0 pb-lg-5 pb-sm-4 pb-2"><a class="fs-sm text-uppercase text-decoration-none" href="#">${place.place_type } / ${place.place_act }</a>
                  <h3 class="h5 pt-1 mb-2"><a class="nav-link" href="placeDetail?place_id=${place.place_id}&page=${page}&state=cont">${place.place_name }</a></h3>
                  <p class="fs-sm text-muted">${place.place_content }</p><a class="d-flex align-items-center text-decoration-none" href="#">
                    <div class="ps-2">
                      <div class="d-flex text-body fs-xs"><span class="me-2 pe-1"><i class="fi-calendar-alt opacity-70 mt-n1 me-1 align-middle"></i>${place.place_hour }</span><span><i class="fi-chat-circle opacity-70 mt-n1 me-1 align-middle"></i>${place.place_rate }</span></div>
                    </div></a>
                </div>
              </article>
              </c:forEach>
           </div>
           
            <!-- Pagination-->
            <c:if test="${listCount > 0 }">
            <nav class="border-top pb-md-4 pt-4 mt-2" aria-label="Pagination">
              <ul class="pagination mb-1">
                <li class="page-item d-sm-none"><span class="page-link page-link-static">1 / 10</span></li>
                
				<!-- 이전 블럭 -->
                <c:if test="${startPage > 10 }">
                <li class="page-item"><a class="page-link" href="placeList?page=${startPage-10 }" aria-label="Next"><i class="fi-chevron-left"></i></a></li>
                </c:if>
                
                <!-- 1 페이지 -->
                <c:if test="${page != 1 && startPage != 1}">
                <li class="page-item d-none d-sm-block"><a class="page-link" href="placeList?page=1">1</a></li>
                <li class="page-item d-none d-sm-block">...</li>
                </c:if>
                
                <!-- 블럭 당 페이지 출력 -->
                <c:forEach var="i" begin="${startPage }" end="${endPage }">
                <c:if test="${i == page }">
                <li class="page-item active d-none d-sm-block" aria-current="page"><span class="page-link">${i}<span class="visually-hidden">(current)</span></span></li>
                </c:if>
                <c:if test="${i != page}">
                <li class="page-item d-none d-sm-block"><a class="page-link" onclick="placeFilterPage(${i})">${i}</a></li>
                </c:if>
                </c:forEach>
                
                <!-- 마지막 페이지 -->
                <c:if test="${endPage != pageCount}">
                <li class="page-item d-none d-sm-block">...</li>
                <li class="page-item d-none d-sm-block"><a class="page-link" href="placeList?page=${pageCount}">${pageCount}</a></li>
                </c:if>
                
                <!-- 다음 블럭 -->
                <c:if test="${endPage < pageCount}">
                <li class="page-item"><a class="page-link" href="placeList?page=${startPage+10 }" aria-label="Next"><i class="fi-chevron-right"></i></a></li>
                </c:if>
                
              </ul>
            </nav>
            </c:if>
            
          </div>
