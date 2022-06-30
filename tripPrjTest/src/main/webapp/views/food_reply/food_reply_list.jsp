<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<head>
<script type="text/javascript">
	$(function() {
		$('#modify').click(function() {	
			var id  = $(this).val(); 
			alert(id);
			var txt = $('#p_'+id).text(); 
			$('#p_'+id).html("<textarea rows='3' cols='70' id='rett_"+id+"'>"+txt		
				+"</textarea>");
			$('#ul_'+id).html(			
			   "<button class='dropdown-item' onclick='modi("+id+")'><i class='fi-heart opacity-60 me-2'></i>확인</button>"
			  +"<button class='dropdown-item' onclick='cancel()'><i class='fi-heart opacity-60 me-2'></i>취소</button>");
		});
	});
	
	// 취소 눌렀을시
	function cancel(){
		history.go(0);
	};
	
	// 수정 확인 눌렀을시
	function modi(id){
		var reply_content = $('#rett_'+id).val();
		var formData = "food_reply_id="+id+'&reply_content='+reply_content+'&page=${page}&food_id=${food_id}';
		$.post('foodReplywModify', formData, function(data){
			history.go(0);
		});
	};
	
	// 삭제 눌렀을시
	function del(food_reply_id, food_id, page) {			
		var formData='food_reply_id='+food_reply_id+'&food_id='+food_id+'&page='+page;
		$.post('foodReplyDelete',formData, function(data) {
			history.go(0);
		});
	};

</script>

</head>

<c:forEach var="foodReplyList" items="${foodReplyList }">

	<div class="border-start border-4 ps-4 ms-4 mt-4">
		<div class="d-flex justify-content-between mb-3">
			<div class="d-flex align-items-center pe-2">
				<c:if test="${!empty foodReplyList.userphoto}">
				<img class="rounded-circle me-1" src="<%=request.getContextPath()%>/upload/${foodReview.userphoto}" width="48">
				</c:if>
				<c:if test="${empty foodReplyList.userphoto}">
				<img class="rounded-circle me-1" src="img/avatars/18.png" width="48"
					alt="Avatar">
				</c:if>
				<div class="ps-2">
					<h6 class="fs-base mb-0">${foodReplyList.id }</h6>
					<span class="text-muted fs-sm">${foodReplyList.reply_reg }</span>
				</div>
			</div>
			
			
			<c:if test="${foodReplyList.id == sessionScope.id }">
			<button type="button"
				class="btn btn-icon btn-light btn-xs rounded-circle shadow-sm"
				id="contextMenu" data-bs-toggle="dropdown" aria-expanded="false">
				<i class="fi-dots-vertical"></i>
			</button>

			<ul class="dropdown-menu my-1" aria-labelledby="contextMenu" id="ul_${foodReplyList.food_reply_id}">
				<li >
					<button type="button" class="dropdown-item" value="${foodReplyList.food_reply_id}" id="modify">
						<i class="fi-heart opacity-60 me-2"></i> 수정
					</button>
				</li>
				<li>
					<button type="button" class="dropdown-item" onclick="del(${foodReplyList.food_reply_id},${food_id },${page })">
						<i class="fi-heart opacity-60 me-2"></i> 삭제
					</button>
				</li>
			</ul>
			
			</c:if>
		</div>
		<p id="p_${foodReplyList.food_reply_id}" >${foodReplyList.reply_content }</p>
	</div>
</c:forEach>



