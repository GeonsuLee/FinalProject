package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.RoomReviewDao;
import com.model.FoodReviewBean;
import com.model.RoomReviewBean;

@Service
public class RoomReviewService {

	@Autowired
	private RoomReviewDao dao;
	

	// 게시판 작성
	public void insertReview(RoomReviewBean roomreview) throws Exception{
		dao.insertReview(roomreview);
	}
	
	
	// 리뷰글 총 갯수
	public int getListCount(int room_id) throws Exception{
		return dao.getListCount(room_id);
	}
	
	
	// 리뷰 리스트
	public List<RoomReviewBean> getRoomReviewList(int page) throws Exception{
		return dao.getReviewList(page);
	}
	
	
	// 리뷰 수정
	public void reviewModify(RoomReviewBean roomReview) {
		dao.reviewModify(roomReview);
	}
	
	// 리뷰 상세정보
	public RoomReviewBean reviewDetail(int room_rev_id) throws Exception{
		
		RoomReviewBean roomReview = dao.reviewDetail(room_rev_id);
		
		return roomReview;
	}


	// 리뷰 삭제
	public void reviewDelete(int room_rev_id) throws Exception{
		dao.reviewDelete(room_rev_id);
	}
	
	
	// 리뷰 평점
	public double getRoomStar(int room_id) throws Exception{
		return dao.getRoomStar(room_id);	
	}
}
