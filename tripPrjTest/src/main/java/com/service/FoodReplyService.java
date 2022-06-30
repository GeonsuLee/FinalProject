package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.FoodReplyDao;
import com.model.FoodReplyBean;
import com.model.FoodReviewBean;

@Service
public class FoodReplyService {
	
	@Autowired
	private FoodReplyDao dao;
	
	// 음식 리뷰 댓글 작성
	public void insertReply(FoodReplyBean foodReview) throws Exception{
		dao.insertReply(foodReview);
	}
	
	// 음식 리뷰 댓글의 총 갯수
	public int getListCount(int food_rev_id) throws Exception{
		return dao.getListCount(food_rev_id);
	}
	
	// 음식 리뷰 댓글 리스트
	public List<FoodReplyBean> getFoodReplyList(int food_rev_id) throws Exception{
		return dao.getFoodReplyList(food_rev_id);
	}
	
	// 음식 댓글 삭제
	public void replyDelete(int food_reply_id) throws Exception{
		dao.replyDelete(food_reply_id);
	}
	
	// 음식 댓글 상세정보
	public FoodReplyBean replyDetail(int food_rev_id) throws Exception{
		
		FoodReplyBean reply = dao.replyDetail(food_rev_id);
		
		return reply;
	}

	
	// 음식 댓글 수정
	public void replyModify(FoodReplyBean replyBean) {
		dao.replyModify(replyBean);
	}
	
}
