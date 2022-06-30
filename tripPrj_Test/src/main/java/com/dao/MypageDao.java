package com.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.model.MemberBean;

@Repository
public class MypageDao {
	
	@Autowired
	private SqlSession session;
	
	// 로그인 인증 확인
	public MemberBean userDetail(String id) throws Exception {

		return session.selectOne("memberns.user_detail", id);
	}
	
	// 회원정보 수정
	public void updateMember(MemberBean mypage) throws Exception {
		session.update("mypagens.mypage_modify", mypage);
	}
	
//	// 회원탈퇴
//	public void deleteMember(MemberBean delm) throws Exception {
//		session.update("mypagens.mypage_delete", delm);
//	}
	
	// 내 리뷰 갯수
//	public int getReviewCount() throws Exception {
//		int count = 0;	
//		count = ((Integer) session.selectOne("mypagens.getReviewCount")).intValue();
//
//		return count;
//	}
//	
//	// 내 리뷰 목록
//	public List<ReviewBean> getReviewList(int page) throws Exception {
//		List<ReviewBean> list = session.selectList("mypagens.getReviewList", page);
//
//		return list;
//	}
//	
//	// 내 문의 갯수
//	public int getQnaCount() throws Exception {
//		int count = 0;	
//		count = ((Integer) session.selectOne("mypagens.getQnaCount")).intValue();
//
//		return count;
//	}
//	
//	// 내 문의 목록
//	public List<QnaBean> getQnaList(int page) throws Exception {
//		List<QnaBean> list = session.selectList("mypagens.getQnaList", page);
//
//		return list;
//	}
//	
//	// 내 북마크 갯수
//	public int getBookmarkCount() throws Exception {
//		int count = 0;	
//		count = ((Integer) session.selectOne("mypagens.getBookmarkCount")).intValue();
//
//		return count;
//	}
//	
//	// 내 북마크 목록
//	public List<BookmarkBean> getBookmarkList(int page) throws Exception {
//		List<BookmarkBean> list = session.selectList("mypagens.getBookmarkList", page);
//
//		return list;
//	}
//
//	// 내 예약 갯수
//	public int getAccomCount() throws Exception {
//		int count = 0;	
//		count = ((Integer) session.selectOne("mypagens.getAccomCount")).intValue();
//
//		return count;
//	}
//	
//	// 내 예약 목록
//	public List<AccomBean> getAccomList(int page) throws Exception {
//		List<AccomBean> list = session.selectList("mypagens.getAccomList", page);
//
//		return list;
//	}
  }
