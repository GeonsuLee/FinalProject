package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.PlaceReplyDao;
import com.model.FoodReplyBean;
import com.model.PlaceReplyBean;

@Service
public class PlaceReplyService {
	
	@Autowired
	private PlaceReplyDao dao;
	
	// 음식 리뷰 댓글 작성
	public void insertReply(PlaceReplyBean foodReview) throws Exception{
		dao.insertReply(foodReview);
	}
	
	// 음식 리뷰 댓글의 총 갯수
	public int getListCount(int place_rev_id) throws Exception{
		return dao.getListCount(place_rev_id);
	}
	
	// 음식 리뷰 댓글 리스트
	public List<PlaceReplyBean> getPlaceReplyList(int place_rev_id) throws Exception{
		return dao.getPlaceReplyList(place_rev_id);
	}
	
	// 음식 댓글 삭제
	public void replyDelete(int place_rev_id) throws Exception{
		dao.replyDelete(place_rev_id);
	}
	
	
	// 음식 댓글 상세정보
	public PlaceReplyBean replyDetail(int place_rev_id) throws Exception{
		
		PlaceReplyBean reply = dao.replyDetail(place_rev_id);
		
		return reply;
	}

	
	// 음식 댓글 수정
	public void replyModify(PlaceReplyBean replyBean) {
		dao.replyModify(replyBean);
	}
}
