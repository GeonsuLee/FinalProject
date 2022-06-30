<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>



<c:forEach var="placeReplyList" items="${placeReplyList }">

	<div class="border-start border-4 ps-4 ms-4 mt-4">
		<div class="d-flex justify-content-between mb-3">
			<div class="d-flex align-items-center pe-2">
				<img class="rounded-circle me-1" src="img/avatars/18.png" width="48"
					alt="Avatar">
				<div class="ps-2">
					<h6 class="fs-base mb-0">${placeReplyList.id }</h6>
					<span class="text-muted fs-sm">${placeReplyList.reply_reg }</span>
				</div>
			</div>
			<button type="button"
				class="btn btn-icon btn-light btn-xs rounded-circle shadow-sm"
				id="contextMenu" data-bs-toggle="dropdown" aria-expanded="false">
				<i class="fi-dots-vertical"></i>
			</button>
			<ul class="dropdown-menu my-1" aria-labelledby="contextMenu">
				<li>
					<button type="button" class="dropdown-item">
						<i class="fi-heart opacity-60 me-2"></i> 이 리뷰 신고하기
					</button>
				</li>
			</ul>
		</div>
		<p>${placeReplyList.reply_content }</p>
	</div>
</c:forEach>



