package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.MypageDao;
import com.model.FoodBookmarkBean;
import com.model.FoodQnaBean;
import com.model.FoodReviewBean;
import com.model.MemberBean;
import com.model.PlaceBookmarkBean;
import com.model.PlaceQnaBean;
import com.model.PlaceReviewBean;
import com.model.RoomBookmarkBean;
import com.model.RoomQnaBean;
import com.model.RoomReviewBean;

@Service
public class MypageService {

	@Autowired
	private MypageDao dao;

	public MemberBean userDetail(String id) throws Exception {
		return dao.userDetail(id);
	}

	public void updateMember(MemberBean mypage) throws Exception {
		dao.updateMember(mypage);
	}

	public void deleteMember(MemberBean delm) throws Exception {
		dao.deleteMember(delm);
	}
	
	// 식당 북마크 목록
	public List<FoodBookmarkBean> getFoodId(String id) throws Exception {
		return dao.getFoodId(id);
	}
	
	// 명소 북마크 목록
	public List<PlaceBookmarkBean> getPlaceId(String id) throws Exception {
		return dao.getPlaceId(id);
	}
	
	// 숙소 북마크 목록
	public List<RoomBookmarkBean> getRoomId(String id) throws Exception {
		return dao.getRoomId(id);
	}

	// 식당 리뷰 목록
	public List<FoodReviewBean> getFoodReview(String id) throws Exception {
		return dao.getFoodReview(id);
	}
	
	// 명소 리뷰 목록
	public List<PlaceReviewBean> getPlaceReview(String id) throws Exception {
		return dao.getPlaceReview(id);
	}
	
	// 숙소 리뷰 목록
	public List<RoomReviewBean> getRoomReview(String id) throws Exception {
		return dao.getRoomReview(id);
	}
	
	// 식당 문의 목록
	public List<FoodQnaBean> getFoodQna(String id) throws Exception {
		return dao.getFoodQna(id);
	}
	
	// 명소 문의 목록
	public List<PlaceQnaBean> getPlaceQna(String id) throws Exception {
		return dao.getPlaceQna(id);
	}
	
	// 숙소 문의 목록
	public List<RoomQnaBean> getRoomQna(String id) throws Exception {
		return dao.getRoomQna(id);
	}
	
	// 식당 북마크 지우기
	public int delFoodMark(FoodBookmarkBean foodbookmark) throws Exception {
		return dao.delFoodMark(foodbookmark);
	}
	
	// 명소 북마크 지우기
	public int delPlaceMark(PlaceBookmarkBean placebookmark) throws Exception {
		return dao.delPlaceMark(placebookmark);
	}
	
	// 숙소 북마크 지우기
	public int delRoomMark(RoomBookmarkBean roombookmark) throws Exception {
		return dao.delRoomMark(roombookmark);
	}
}
