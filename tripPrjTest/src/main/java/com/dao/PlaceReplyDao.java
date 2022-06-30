package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.FoodReplyBean;
import com.model.PlaceReplyBean;

@Repository
public class PlaceReplyDao {
	
	@Autowired
	private SqlSession session;
	
	// 장소 리뷰 댓글 작성
	@Transactional
	public void insertReply(PlaceReplyBean reply) throws Exception{
		session.insert("placeReplyns.placeReplyInsert", reply);
	}
	
	// 장소 리뷰 댓글 총 갯수
	public int getListCount() throws Exception{
		int count = 0;
		count = ((Integer) session.selectOne("placeReplyns.placeReplyCount")).intValue();
		return count;
	}
	
	// 장소 리뷰 댓글 리스트
	public List<PlaceReplyBean> getPlaceReplyList(int place_rev_id) throws Exception{
		List<PlaceReplyBean> list = session.selectList("placeReplyns.placeReplyList", place_rev_id);
		return list;
	}
	
	// 장소 댓글 삭제
	public void replyDelete(int place_rev_id) throws Exception{
		session.delete("placeReplyns.replyDelete", place_rev_id);
	}
	
	// 장소 댓글 상세
		public PlaceReplyBean replyDetail(int place_reply_id) throws Exception{
			return(PlaceReplyBean)session.selectOne("placeReplyns.placeReplyDetail", place_reply_id);
		}
		
	// 장소 댓글 수정
	public void replyModify(PlaceReplyBean replyBean) {
		session.update("placeReplyns.replyModify", replyBean);
	}
}
