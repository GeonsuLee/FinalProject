package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.model.FoodLikeBean;
import com.model.FoodReviewBean;

@Repository
public class FoodReviewDao {

	@Autowired
	private SqlSession session;

	
	// 리뷰 작성
	@Transactional
	public void insertReview(FoodReviewBean fr) throws Exception {
		session.insert("foodReviewns.foodReivewInsert", fr);
	}
	
	
	// 리뷰 게시판 글 갯수
	public int getListCount(int food_id) throws Exception{
		int count = 0;
		count = ((Integer) session.selectOne("foodReviewns.foodReviewCount", food_id)).intValue();
		return count;
	}
	
	
	// 리뷰 게시판 목록
	public List<FoodReviewBean> getReviewList(int food_id) throws Exception {
		List<FoodReviewBean> list = session.selectList("foodReviewns.foodReviewList", food_id);
		return list;
	}
	
	
	// 리뷰 상세페이지
	public FoodReviewBean reviewDetail(int food_rev_id) throws Exception{
		return(FoodReviewBean)session.selectOne("foodReviewns.foodReviewDetail", food_rev_id);
	}
	
	// 리뷰 수정
	public void reviewModify(FoodReviewBean review) {
		session.update("foodReviewns.foodReviewModify", review);
	}

	// 리뷰 삭제
	public void reviewDelete(int food_rev_id) throws Exception{
		session.delete("foodReviewns.reviewDelete", food_rev_id);
	}
	
	// 리뷰 평점
	public double getFoodStar(int food_id) throws Exception{
		double foodStar = 0;
		return foodStar = session.selectOne("foodReviewns.reviewStar", food_id);
	}
	
	// 리뷰 좋아요
	public void foodLikeUpdate(int food_rev_id) throws Exception{
		session.update("foodReviewns.foodLikeUpdate", food_rev_id);
	}
	
	// 리뷰좋아요 테이블에 데이터 저장
	public void foodLikeInsert(FoodLikeBean likebean) throws Exception{
		session.insert("foodReviewns.foodLikeInsert", likebean);
	}
	
	// 리뷰좋아요 리스트
	public List<FoodLikeBean> getFoodLikeList(String id) throws Exception{
		List<FoodLikeBean> reviewLike = session.selectList("foodReviewns.getFoodLikeList", id);
		return reviewLike;
	}
	
	// 리뷰 좋아요 food_rev_id
	public int getFoodRevId(String id) throws Exception{
		int food_rev_id = 0;
		return food_rev_id = session.selectOne("foodReviewns.getFoodRevId", id);
	}
	
}
