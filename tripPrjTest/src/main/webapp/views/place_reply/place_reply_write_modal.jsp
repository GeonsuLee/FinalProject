<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
    
<!DOCTYPE html>
<head>


</head>

<body>


          <div class="modal-content" >
            <div class="modal-header d-block position-relative border-0 pb-0 px-sm-5 px-4">
              <h3 class="modal-title mt-4 text-center">댓글을 남겨주세요</h3>
              <button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-sm-5 px-4" id="">
            
              <form class="needs-validation" action="placeReplyWrite?place_rev_id=${place_rev_id}" method="post">
              <input type="hidden" name="id" id="id" value="${sessionScope.id }">
                <div class="mb-4">
                  <label class="form-label" for="review-text">댓글 <span class='text-danger'>*</span></label>
                  <textarea class="form-control"  name="reply_content" rows="5" placeholder="댓글 내용" required></textarea>
                  <div class="invalid-feedback">댓글을 작성해주세요.</div>
                </div>
                <button class="btn btn-primary d-block w-100 mb-4" type="submit">글쓰기</button>
                
              </form>
            </div>
          </div> 
          
        
</body>          