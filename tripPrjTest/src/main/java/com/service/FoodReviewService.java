package com.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.FoodReviewDao;
import com.model.FoodLikeBean;
import com.model.FoodReviewBean;

@Service
public class FoodReviewService {
	
	
	@Autowired
	private FoodReviewDao dao;
	

	// 게시판 작성
	public void insertReview(FoodReviewBean foodReview) throws Exception{
		dao.insertReview(foodReview);
	}
	
	
	// 리뷰글 총 갯수
	public int getListCount(int food_id) throws Exception{
		return dao.getListCount(food_id);
	}
	
	
	// 리뷰 리스트
	public List<FoodReviewBean> getFoodReviewList(int food_id) throws Exception{
		return dao.getReviewList(food_id);
	}
	
	
	// 리뷰 수정
	public void reviewModify(FoodReviewBean FoodReview) {
		dao.reviewModify(FoodReview);
	}
	
	// 리뷰 상세정보
	public FoodReviewBean reviewDetail(int food_rev_id) throws Exception{
		
		FoodReviewBean FoodReview = dao.reviewDetail(food_rev_id);
		
		return FoodReview;
	}


	// 리뷰 삭제
	public void reviewDelete(int food_rev_id) throws Exception{
		dao.reviewDelete(food_rev_id);
	}
	
	
	// 리뷰 평점
	public double getFoodStar(int food_id) throws Exception{
		return dao.getFoodStar(food_id);	
	}
	
	
	// 리뷰 좋아요
	public void foodLikeUpdate(int food_rev_id) throws Exception{
		dao.foodLikeUpdate(food_rev_id);
	}
	
	// 리뷰좋아요 테이블에 데이터 저장
	public void foodLikeInsert(FoodLikeBean likebean) throws Exception{
		dao.foodLikeInsert(likebean);
	}
	
	// 리뷰 좋아요 리스트 구해오기
	public List<FoodLikeBean>  getFoodLikeList(String id) throws Exception{
		return dao.getFoodLikeList(id);
	}
	
	// 리뷰 좋아요 food_rev_id 구해오기
	public int getFoodRevId(String id) throws Exception{
		return dao.getFoodRevId(id);
	}
}
