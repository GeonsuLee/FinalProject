package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.RoomReplyDao;
import com.model.FoodReplyBean;
import com.model.RoomReplyBean;

@Service
public class RoomReplyService {
	
	@Autowired
	private RoomReplyDao dao;
	
	// 숙박 리뷰 댓글 작성
	public void insertReply(RoomReplyBean roomReview) throws Exception{
		dao.insertReply(roomReview);
	}
	
	// 숙박 리뷰 댓글의 총 갯수
	public int getListCount(int room_rev_id) throws Exception{
		return dao.getListCount(room_rev_id);
	}
	
	// 숙박 리뷰 댓글 리스트
	public List<RoomReplyBean> getRoomReplyList(int room_rev_id) throws Exception{
		return dao.getRoomReplyList(room_rev_id);
	}
	
	// 숙박 댓글 삭제
	public void replyDelete(int room_rev_id) throws Exception{
		dao.replyDelete(room_rev_id);
	}
	
	// 숙박 댓글 상세정보
	public RoomReplyBean replyDetail(int room_rev_id) throws Exception{
		
		RoomReplyBean reply = dao.replyDetail(room_rev_id);
		
		return reply;
	}

	
	// 음식 댓글 수정
	public void replyModify(RoomReplyBean replyBean) {
		dao.replyModify(replyBean);
	}
	

}
