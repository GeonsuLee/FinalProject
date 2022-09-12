package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.FoodReplyBean;
import com.model.RoomReplyBean;

@Repository
public class RoomReplyDao {

	@Autowired
	private SqlSession session;
	
	// 숙박 리뷰 댓글 작성
	@Transactional
	public void insertReply(RoomReplyBean reply) throws Exception{
		session.insert("roomReplyns.roomReplyInsert", reply);
	}
	
	// 숙박 리뷰 댓글 총 갯수
	public int getListCount(int room_rev_id) throws Exception{
		int count = 0;
		count = ((Integer) session.selectOne("roomReplyns.roomReplyCount", room_rev_id)).intValue();
		return count;
	}
	
	// 숙박 리뷰 댓글 리스트
	public List<RoomReplyBean> getRoomReplyList(int room_rev_id) throws Exception{
		List<RoomReplyBean> list = session.selectList("roomReplyns.roomReplyList", room_rev_id);
		return list;
	}
	
	// 숙박 댓글 삭제
	public void replyDelete(int room_rev_id) throws Exception{
		session.delete("roomReplyns.replyDelete", room_rev_id);
	}
	
	// 음식 댓글 상세
	public RoomReplyBean replyDetail(int room_reply_id) throws Exception{
		return(RoomReplyBean)session.selectOne("roomReplyns.roomReplyDetail", room_reply_id);
	}
		
	// 음식 댓글 수정
	public void replyModify(RoomReplyBean replyBean) {
			session.update("roomReplyns.replyModify", replyBean);
	}
}
