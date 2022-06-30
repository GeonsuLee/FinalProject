package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.FoodReplyBean;

@Repository
public class FoodReplyDao {

	@Autowired
	private SqlSession session;
	
	// 음식 리뷰 댓글 작성
	@Transactional
	public void insertReply(FoodReplyBean reply) throws Exception{
		session.insert("foodReplyns.foodReplyInsert", reply);
	}
	
	// 음식 리뷰 댓글 총 갯수
	public int getListCount(int food_rev_id) throws Exception{
		int count = 0;
		count = ((Integer) session.selectOne("foodReplyns.foodReplyCount",food_rev_id)).intValue();
		return count;
	}
	
	// 음식 리뷰 댓글 리스트
	public List<FoodReplyBean> getFoodReplyList(int food_rev_id) throws Exception{
		List<FoodReplyBean> list = session.selectList("foodReplyns.foodReplyList", food_rev_id);
		return list;
	}
	
	// 음식 댓글 삭제
	public void replyDelete(int food_rev_id) throws Exception{
		session.delete("foodReplyns.replyDelete", food_rev_id);
	}
	
	// 음식 댓글 상세
	public FoodReplyBean replyDetail(int food_reply_id) throws Exception{
		return(FoodReplyBean)session.selectOne("foodReplyns.foodReplyDetail", food_reply_id);
	}
	
	// 음식 댓글 수정
	public void replyModify(FoodReplyBean replyBean) {
		session.update("foodReplyns.replyModify", replyBean);
	}
}
