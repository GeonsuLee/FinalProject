package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.PlaceReviewBean;

@Repository
public class PlaceReviewDao {

	@Autowired
	private SqlSession session;

	
	// 리뷰 작성
	@Transactional
	public void insertReview(PlaceReviewBean pr) throws Exception {
		session.insert("placeReviewns.placeReivewInsert", pr);
	}
	
	
	// 리뷰 게시판 글 갯수
	public int getListCount(int place_id) throws Exception{
		int count = 0;
		count = ((Integer) session.selectOne("placeReviewns.placeReviewCount",place_id)).intValue();
		return count;
	}
	
	
	// 리뷰 게시판 목록
	public List<PlaceReviewBean> getReviewList(int place_id) throws Exception {
		List<PlaceReviewBean> list = session.selectList("placeReviewns.placeReviewList", place_id);
		return list;
	}
	
	
	// 리뷰 상세페이지
	public PlaceReviewBean reviewDetail(int place_rev_id) throws Exception{
		return(PlaceReviewBean)session.selectOne("placeReviewns.placeReviewDetail", place_rev_id);
	}
	
	// 리뷰 수정
	public void reviewModify(PlaceReviewBean review) {
		session.update("placeReviewns.placeReviewModify", review);
	}

	// 리뷰 삭제
	public void reviewDelete(int place_rev_id) throws Exception{
		session.delete("placeReviewns.reviewDelete", place_rev_id);
	}
	
	// 리뷰 평점
	public double getPlaceStar(int place_id) throws Exception{
		double placeStar = 0;
		return placeStar = session.selectOne("placeReviewns.reviewStar", place_id);
	}
	
}
