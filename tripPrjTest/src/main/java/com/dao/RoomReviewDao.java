package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.RoomReviewBean;

@Repository
public class RoomReviewDao {
	
	@Autowired
	private SqlSession session;

	
	// 리뷰 작성
	@Transactional
	public void insertReview(RoomReviewBean rr) throws Exception {
		session.insert("roomReviewns.roomReivewInsert", rr);
	}
	
	
	// 리뷰 게시판 글 갯수
	public int getListCount(int room_id) throws Exception{
		int count = 0;
		count = ((Integer) session.selectOne("roomReviewns.roomReviewCount", room_id)).intValue();
		return count;
	}
	
	
	// 리뷰 게시판 목록
	public List<RoomReviewBean> getReviewList(int page) throws Exception {
		List<RoomReviewBean> list = session.selectList("roomReviewns.roomReviewList", page);
		return list;
	}
	
	
	// 리뷰 상세페이지
	public RoomReviewBean reviewDetail(int room_rev_id) throws Exception{
		return(RoomReviewBean)session.selectOne("roomReviewns.roomReviewDetail", room_rev_id);
	}
	
	// 리뷰 수정
	public void reviewModify(RoomReviewBean review) {
		session.update("roomReviewns.roomReviewModify", review);
	}

	// 리뷰 삭제
	public void reviewDelete(int room_rev_id) throws Exception{
		session.delete("roomReviewns.reviewDelete", room_rev_id);
	}
	
	// 리뷰 평점
	public double getRoomStar(int room_id) throws Exception{
		double foodStar = 0;
		return foodStar = session.selectOne("roomReviewns.reviewStar", room_id);
	}

}
