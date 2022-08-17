<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- Page header-->
    <section class="container pt-5 mt-5"></section>
            <!-- Post content-->
            <section class="container mb-5 pb-1">
                <ul class="nav nav-masthead h5 d-flex flex-wrap pb-3 mb-4" role="tablist">
                    <li class="nav-item"><a class="nav-link text-uppercase text-decoration-none active border-end pe-3 me-3 mb-2" href="#review-list" data-bs-toggle="tab" role="tab" aria-controls="reviews-about-you" aria-selected="true">리뷰</a></li>
                    <li class="nav-item"><a class="nav-link d-flex align-items-center mb-2" href="#qna-list" data-bs-toggle="tab" role="tab" aria-controls="reviews-by-you" aria-selected="false"><span>Q&A</span></a></li>
                </ul>

               
                <div class="row">
                
                	
                    <div class="tab-content col-md-7 mb-md-0 mb-4">
                    
                        <div class="tab-pane fade show active" id="review-list" role="tabpanel">
                            <div class="mb-4 pb-4 border-bottom">
                                <h3 class="h4 pb-3"><i class="fi-star-filled mt-n1 me-2 lead align-middle text-warning"></i>${starAvg } (${listCount})</h3>
								<c:if test="${!empty sessionScope.id}">
								<button class="btn btn-outline-primary mb-sm-0 mb-3" href="#modal-review" data-bs-toggle="modal" onclick="writes(${food_id},${page})">
              					<i class="fi-edit me-1"></i>리뷰 작성</button>   
              					</c:if>                                 
              					<div class="d-flex align-items-center ms-sm-4">
                                        
                                </div>
                                </div>
                            
                            
                            
                            
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
              <h3 class="modal-title mt-4 text-center">리뷰 수정</h3>
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
      


      <!----------------------- Review list	----------------------->
       
      <c:forEach var="foodReview" items="${reviewlist}">
				
				
	            <div class="mb-4 pb-4 border-bottom">
	            
	              <div class="d-flex justify-content-between mb-3">
	                <div class="d-flex align-items-center pe-2">
	                <c:if test="${!empty foodReview.userphoto}">            
	                <img class="rounded-circle me-1" src="<%=request.getContextPath()%>/upload/${foodReview.userphoto}" width="48" alt="Avatar">
	                </c:if>
	                <c:if test="${empty foodReview.userphoto}">
	                <img class="rounded-circle me-1" src="img/avatars/16.png" width="48" alt="Avatar">
	                </c:if> 
	               
					
				 
	                  <div class="ps-2">
	                  <div class="starpoint_wraps">
	                  
	                  
		                  <button type="button" class="dropdown-item" onclick="foodlike(${foodReview.food_rev_id},${food_id },${page })" value="${sessionScope.id }" id="sessionScopeId">
							<i class="fi-heart opacity-60 me-2"></i> 좋아요
						  </button>
						  
						 
	                 	
	                  	
					  
					 	<div class="starpoint_boxs" id="star1">
					 	${foodReviewStar }
					 	<c:forEach var="i" begin="1" end="10">
					 		<input type="radio" name="starpoint" id="starpoint_${i}" class="star_radio" value="${i/2}"   > 
 					    	<label for="starpoint_${i}"  class="label_star" title="${i/2}"><span class="blind">${i/2}점</span></label> 
 					    </c:forEach>	
					   		<span class="starpoint_bg" style="width: 70% !important"></span>
					  	</div>
					  	
						</div>
	                  		
	                    <h6 class="fs-base mb-0">${foodReview.id}</h6> </div>
	                </div><span class="text-muted fs-sm">${foodReview.rev_reg}</span>
	              </div>
	              <p>${foodReview.rev_content}</p>
	              <div class="fs-base mb-0">
	              
	              <c:if test="${!empty foodReview.rev_photo}">
	              <c:forTokens var="photo" items="${foodReview.rev_photo}" delims=",">
						<img src="<%=request.getContextPath()%>/upload/${photo}" height="100" width="100"/>
				  </c:forTokens>
				  </c:if>
				  
					</div>
					
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="d-flex align-items-center pe-2"><button class="btn-like" type="button">
	                <i></i><span></span></button>
	                </div>
	                <c:if test="${sessionScope.id != null}">
	                <button class="btn btn-link btn-sm" type="button" href="#modal-reply" data-bs-toggle="modal"
	                onclick="reply(${foodReview.food_rev_id },${page },${foodReview.food_id })">
	                <i class="fi-reply fs-lg me-2"></i><span class="fw-normal">댓글</span></button>
	              	</c:if>
	              </div>
	              
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="d-flex align-items-center pe-2"></div>
	                <c:if test="${foodReview.id == sessionScope.id}">
	                <button class="btn btn-link btn-sm" type="button"  id="test1"  href="#modal-review-modify"  data-bs-toggle="modal" onclick="modify(${foodReview.food_rev_id },${food_id },${page })">
	  			      <i class="fi-reply fs-lg me-2"></i><span class="fw-normal">수정</span></button>
	    			</c:if>
	              </div>
	              
	              <div class="d-flex justify-content-between align-items-center">
	                <div class="d-flex align-items-center pe-2"></div>
	                <c:if test="${foodReview.id == sessionScope.id}">
	                 <button type="button" value="삭제" class="btn btn-link btn-sm" onclick="location='foodReviewDelete?food_rev_id=${foodReview.food_rev_id}&food_id=${food_id }&page=${page }'" >
	                <i class="fi-reply fs-lg me-2"></i><span class="fw-normal">삭제</span></button>     
	              	</c:if>
	              </div>
	              
                 
	                
	               <a class="collapse-label collapsed" href="#seeMoreOverview_${foodReview.food_rev_id}" data-bs-toggle="collapse" data-bs-label-collapsed="댓글 보기" data-bs-label-expanded="접기" role="button" aria-expanded="false" aria-controls="seeMoreOverview" 
                  	onclick="replyList(${foodReview.food_rev_id },${food_id },${page })"></a>
	                
              <!-- Reply to comment-->
              <div class="collapse" id="seeMoreOverview_${foodReview.food_rev_id}">
    		  <!-- load메소드로 댓글 리스트 불러오는 영역 -->
              </div>
              
    		  </div>
              </c:forEach>    
                            
  							 Pagination
                            <nav class="mt-2 mb-4" aria-label="Reviews pagination">
                                <ul class="pagination">
                                    <li class="page-item d-sm-none"><span class="page-link page-link-static">1 / 5</span></li>
                                    <li class="page-item active d-none d-sm-block" aria-current="page"><span class="page-link">1<span class="visually-hidden">(current)</span></span></li>
                                    <li class="page-item d-none d-sm-block"><a class="page-link" href="#">2</a></li>
                                    <li class="page-item d-none d-sm-block"><a class="page-link" href="#">3</a></li>
                                    <li class="page-item d-none d-sm-block">...</li>
                                    <li class="page-item d-none d-sm-block"><a class="page-link" href="#">8</a></li>
                                    <li class="page-item"><a class="page-link" href="#" aria-label="Next"><i class="fi-chevron-right"></i></a></li>
                                </ul>
                            </nav>
                        </div>

            <%@ include file="../food/qna_modal.jsp" %>

            <!-- 문의 -->
            <div class="tab-pane fade" id="qna-list" role="tabpanel">

                <!-- Reviews-->
                <div class="mb-4 pb-4 border-bottom">
                    <div class="d-flex flex-sm-row flex-column align-items-sm-center align-items-stretch justify-content-between"><a class="btn btn-outline-primary mb-sm-0 mb-3" href="#modal-question" data-bs-toggle="modal"><i class="fi-edit me-1"></i>문의 하기</a>
                    </div>
                </div>
                <!-- Review-->
                <div class="mb-4 pb-4 border-bottom">
                    <div class="d-flex justify-content-between mb-3">
                        <div class="d-flex align-items-center pe-2"><img class="rounded-circle me-1" src="img/avatars/16.png" width="48" alt="Avatar">
                            <div class="ps-2">
                                <h6 class="fs-base mb-0">${food_id}</h6>
                                <span class="text-muted fs-sm">작성일</span>
                            </div>
                        </div>
                        <button class="btn btn-icon btn-light btn-xs rounded-circle shadow-sm" type="button" id="contextMenu1" data-bs-toggle="dropdown" aria-expanded="false"><i class="fi-dots-vertical"></i></button>
                        <ul class="dropdown-menu my-1" aria-labelledby="contextMenu1">
                            <li>
                                <button class="dropdown-item" type="button"><i class="fi-edit opacity-60 me-2"></i>수정</button>
                            </li>
                            <li>
                                <button class="dropdown-item" type="button"><i class="fi-trash opacity-60 me-2"></i>삭제</button>
                            </li>
                        </ul>
                    </div>
                    <p>나는 가슴속에 새겨지는 우는 벌써 까닭입니다. 하나에 같이 이국 그리워 불러 이 언덕 거외다. 밤이 불러 이런 봄이 가슴속에 토끼, 못 오는 까닭입니다. 불러 멀리 쓸쓸함과 봅니다. 하나에 별 옥 내일 다하지 이런 무엇인지 있습니다. 별을 다 아직 듯합니다. 옥 걱정도 이네들은 피어나듯이 딴은 내린 오면 별빛이 이름과, 버리었습니다. 별 지나가는 내일 언덕 책상을 둘 별 거외다. 헤는 별에도 비둘기, 오는 봄이 나는 어머님, 까닭입니다. 하나에 비둘기, 속의 있습니다. 멀듯이, 잠, 했던 계집애들의 소학교 마디씩 봅니다.</p>
                    <div class="d-flex justify-content-between align-items-center">
                        <div></div>
                        <button class="btn btn-link btn-sm" type="button" href="#modal-answer" data-bs-toggle="modal"><i class="fi-reply fs-lg me-2"></i><span class="fw-normal">답장</span></button>
                    </div>
                    <!-- Reply to comment-->
                    <div class="collapse" id="seeMoreOverview">
                        <div class="border-start border-4 ps-4 ms-4 mt-4">
                            <div class="d-flex justify-content-between mb-3">
                                <div class="d-flex align-items-center pe-2">
                                    <img class="rounded-circle me-1" src="img/avatars/18.png" width="48" alt="Avatar">
                                    <div class="ps-2">
                                        <h6 class="fs-base mb-0">admin_id</h6>
                                        <span class="text-muted fs-sm">작성일</span>
                                    </div>
                                </div>
                                <button class="btn btn-icon btn-light btn-xs rounded-circle shadow-sm" type="button" id="contextMenu1" data-bs-toggle="dropdown" aria-expanded="false"><i class="fi-dots-vertical"></i></button>
                                <ul class="dropdown-menu my-1" aria-labelledby="contextMenu1">
                                    <li>
                                        <button class="dropdown-item" type="button"><i class="fi-edit opacity-60 me-2"></i>수정</button>
                                    </li>
                                    <li>
                                        <button class="dropdown-item" type="button"><i class="fi-trash opacity-60 me-2"></i>삭제</button>
                                    </li>
                                </ul>
                            </div>
                            <p>이것은 꾸며 이상을 보이는 아름다우냐? 돋고, 미묘한 그들의 찾아다녀도, 품었기 없는 목숨을 것이다. 위하여, 불러 곳이 생의 그들은 피부가 인간의 불어 맺어, 뿐이다. 같은 수 보이는 있는 않는 온갖 것이다. 가장 스며들어 오아이스도 커다란 아니더면, 쓸쓸하랴? 현저하게 커다란 끝에 싸인 일월과 청춘의 피어나기 사막이다. 우리의 뛰노는 봄바람을 투명하되 뿐이다. 수 주는 그림자는 밥을 살았으며, 아니다. 산야에 황금시대의 발휘하기 열락의 천자만홍이 설레는 가슴에 위하여 뿐이다.</p>
                        </div>
                        <div class="border-start border-4 ps-4 ms-4 mt-4">
                            <div class="d-flex justify-content-between mb-3">
                                <div class="d-flex align-items-center pe-2">
                                    <img class="rounded-circle me-1" src="img/avatars/18.png" width="48" alt="Avatar">
                                    <div class="ps-2">
                                        <h6 class="fs-base mb-0">admin_id</h6>
                                        <span class="text-muted fs-sm">작성일</span>
                                    </div>
                                </div>
                                <button class="btn btn-icon btn-light btn-xs rounded-circle shadow-sm" type="button" id="contextMenu1" data-bs-toggle="dropdown" aria-expanded="false"><i class="fi-dots-vertical"></i></button>
                                <ul class="dropdown-menu my-1" aria-labelledby="contextMenu1">
                                    <li>
                                        <button class="dropdown-item" type="button"><i class="fi-edit opacity-60 me-2"></i>수정</button>
                                    </li>
                                    <li>
                                        <button class="dropdown-item" type="button"><i class="fi-trash opacity-60 me-2"></i>삭제</button>
                                    </li>
                                </ul>
                            </div>
                            <p>옷을 평화스러운 착목한는 듣는다. 하여도 있음으로써 간에 튼튼하며, 방황하였으며, 봄바람이다. 보배를 때에, 주며, 황금시대다. 평화스러운 것은 뭇 전인 바이며, 싹이 청춘을 피다. 열락의 지혜는 용기가 사람은 살았으며, 그들을 이 대고, 인간이 있으랴? 풀이 곳이 열매를 전인 보라. 없는 청춘의 용기가 가슴이 있으랴? 없으면, 따뜻한 청춘 쓸쓸한 넣는 끓는다. 미묘한 듣기만 하는 이상을 부패뿐이다. 남는 있을 그들은 이것을 아니다.</p>
                        </div>
                    </div><a class="collapse-label collapsed" href="#seeMoreOverview" data-bs-toggle="collapse" data-bs-label-collapsed="답글 보기" data-bs-label-expanded="접기" role="button" aria-expanded="false" aria-controls="seeMoreOverview"></a>
                </div>

                <c:forEach var="rb" items="${slist}">
                    <tr>
                        <td>${rb.replyer}</td>
                        <td id="td_${rb.rno}">${rb.replytext}</td>
                        <td>${rb.updatedate }</td>
                        <td id="btn_${rb.rno}">
                            <c:if test="${rb.replyer==board.writer }">
                                <input type="button" value="수정" class="edit1" id="${rb.rno}">
                                <input type="button" value="삭제"	 onclick="del(${rb.rno},${rb.bno})">
                            </c:if></td>
                    </tr>
                </c:forEach>


                <!-- Review-->
                <div class="d-flex justify-content-between mb-3">
                    <div class="d-flex align-items-center pe-2"><img class="rounded-circle me-1" src="img/avatars/16.png" width="48" alt="Avatar">
                        <div class="ps-2">
                            <h6 class="fs-base mb-0">member_id</h6>
                            <span class="text-muted fs-sm">작성일</span>
                        </div>
                    </div>
                    <button class="btn btn-icon btn-light btn-xs rounded-circle shadow-sm" type="button" id="contextMenu1" data-bs-toggle="dropdown" aria-expanded="false"><i class="fi-dots-vertical"></i></button>
                    <ul class="dropdown-menu my-1" aria-labelledby="contextMenu1">
                        <li>
                            <button class="dropdown-item" type="button"><i class="fi-edit opacity-60 me-2"></i>수정</button>
                        </li>
                        <li>
                            <button class="dropdown-item" type="button"><i class="fi-trash opacity-60 me-2"></i>삭제</button>
                        </li>
                    </ul>
                </div>
                <p>문의 내용</p>
                <div class="d-flex justify-content-between align-items-center">
                    <div></div>
                    <button class="btn btn-link btn-sm" type="button" href="#modal-reply" data-bs-toggle="modal"><i class="fi-reply fs-lg me-2"></i><span class="fw-normal">답장</span></button>
                </div>
                <!-- Pagination-->
                <nav class="mt-2 mb-4" aria-label="Reviews pagination">
                    <ul class="pagination">
                        <li class="page-item d-sm-none"><span class="page-link page-link-static">1 / 5</span></li>
                        <li class="page-item active d-none d-sm-block" aria-current="page"><span class="page-link">1<span class="visually-hidden">(current)</span></span></li>
                        <li class="page-item d-none d-sm-block"><a class="page-link" href="#">2</a></li>
                        <li class="page-item d-none d-sm-block"><a class="page-link" href="#">3</a></li>
                        <li class="page-item d-none d-sm-block">...</li>
                        <li class="page-item d-none d-sm-block"><a class="page-link" href="#">8</a></li>
                        <li class="page-item"><a class="page-link" href="#" aria-label="Next"><i class="fi-chevron-right"></i></a></li>
                    </ul>
                </nav>
            </div>
        </div>
        </div>
    </section>