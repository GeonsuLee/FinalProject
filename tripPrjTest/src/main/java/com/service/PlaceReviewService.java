package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.PlaceReviewDao;
import com.model.FoodReviewBean;
import com.model.PlaceReviewBean;

@Service
public class PlaceReviewService {
	
	@Autowired
	private PlaceReviewDao dao;
	

	// 게시판 작성
	public void insertReview(PlaceReviewBean placeReview) throws Exception{
		dao.insertReview(placeReview);
	}
	
	
	// 리뷰글 총 갯수
	public int getListCount(int place_id) throws Exception{
		return dao.getListCount(place_id);
	}
	
	
	// 리뷰 리스트
	public List<PlaceReviewBean> getPlaceReviewList(int place_id) throws Exception{
		return dao.getReviewList(place_id);
	}
	
	
	// 리뷰 수정
	public void reviewModify(PlaceReviewBean placeReview) {
		dao.reviewModify(placeReview);
	}
	
	// 리뷰 상세정보
	public PlaceReviewBean reviewDetail(int place_rev_id) throws Exception{
		
		PlaceReviewBean placeReview = dao.reviewDetail(place_rev_id);
		
		return placeReview;
	}


	// 리뷰 삭제
	public void reviewDelete(int place_rev_id) throws Exception{
		dao.reviewDelete(place_rev_id);
	}
	
	
	// 리뷰 평점
	public int getPlaceStar(int place_rev_id) throws Exception{
		return dao.getPlaceStar(place_rev_id);	
	}
	
	
}
