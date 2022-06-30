package com.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.MypageDao;
import com.model.MemberBean;

@Service
public class MypageService {

	@Autowired
	private MypageDao dao;

	// 회원 정보 호출
	public MemberBean userDetail(String id) throws Exception {
		return dao.userDetail(id);
	}

	// 회원정보 수정
	public void updateMember(MemberBean mypage) throws Exception {
		dao.updateMember(mypage);
	}

//	// 회원탈퇴
//	public void deleteMember(MemberBean delm) throws Exception {
//		dao.deleteMember(delm);
//	}

	// 내 리뷰 갯수
//	public int getReviewCount() throws Exception {
//		return dao.getReviewCount();
//	}

//	// 내 리뷰 목록
//	public List<ReviewBean> getReviewList(int page) throws Exception {
//		return dao.getReviewList();
//	}
//
//	// 내 문의 갯수
//	public int getQnaCount() throws Exception {
//		return dao.getQnaCount();
//	}
//
//	// 내 문의 목록
//	public List<QnaBean> getQnaList(int page) throws Exception {
//		return dao.getQnaList();
//	}
//
//	// 내 북마크 갯수
//	public int getBookmarkCount() throws Exception {
//		return dao.getBookmarkCount();
//	}
//
//	// 내 북마크 목록
//	public List<BookmarkBean> getBookmarkList(int page) throws Exception {
//		return dao.getBookmarkList();
//	}
//	
//	// 내 예약 갯수
//	public int getAccomCount() throws Exception {
//		return dao.getAccomCount();
//	}
//	
//	// 내 예약 목록
//	public List<AccomBean> getAccomList(int page) throws Exception {
//		return dao.getAccomList();
//	}
}
