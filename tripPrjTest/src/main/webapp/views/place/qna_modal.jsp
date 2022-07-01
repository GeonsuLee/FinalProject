<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Question modal-->
<div class="modal fade" id="modal-question" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header d-block position-relative border-0 pb-0 px-sm-5 px-4">
                <h3 class="modal-title mt-4 text-center">문의를 남겨주세요</h3>
                <button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-sm-5 px-4">
                <form class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label class="form-label">아이디 <span class='text-danger'>*</span></label>
                        <input class="form-control" type="text" id="qna-name" name="qna_name" value="${member.id}" placeholder="아이디" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Email <span class='text-danger'>*</span></label>
                        <input class="form-control" type="email" id="qna-email" value="${member.mail}" placeholder="이메일" required>
                    </div>

                    <div class="mb-4">
                        <label class="form-label">문의 내용 <span class='text-danger'>*</span></label>
                        <textarea class="form-control" id="qna-text" rows="5" placeholder="문의 내용" required></textarea>
                        <div class="invalid-feedback">문의글을 작성해주세요.</div>
                    </div>
                    <button class="btn btn-primary d-block w-100 mb-4">글쓰기</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Answer modal-->
<div class="modal fade" id="modal-answer" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-header d-block position-relative border-0 pb-0 px-sm-5 px-4">
                <h3 class="modal-title mt-4 text-center">답장을 남겨주세요</h3>
                <button class="btn-close position-absolute top-0 end-0 mt-3 me-3" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body px-sm-5 px-4">
                <form class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label class="form-label" for="review-name">아이디 <span class='text-danger'>*</span></label>
                        <input class="form-control" type="text" id="review-name" placeholder="관리자 아이디" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="review-email">Email <span class='text-danger'>*</span></label>
                        <input class="form-control" type="email" id="review-email" placeholder="관리자 이메일" required>
                    </div>
                    <div class="mb-4">
                        <label class="form-label" for="review-text">답장 <span class='text-danger'>*</span></label>
                        <textarea class="form-control" id="review-text" rows="5" placeholder="답장 내용" required></textarea>
                    </div>
                    <button class="btn btn-primary d-block w-100 mb-4" type="submit">글쓰기</button>
                </form>
            </div>
        </div>
    </div>
</div>