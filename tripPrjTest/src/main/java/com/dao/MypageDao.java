package com.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
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

@Repository
public class MypageDao {

	@Autowired
	private SqlSession session;

	// 회원정보 호출
	public MemberBean userDetail(String id) throws Exception {
		return session.selectOne("mypagens.user_detail", id);
	}

	// 회원정보 수정
	public void updateMember(MemberBean mypage) throws Exception {
		session.update("mypagens.mypage_modify", mypage);
	}

	// 회원탈퇴
	public void deleteMember(MemberBean delm) throws Exception {
		session.update("mypagens.mypage_delete", delm);
	}
	
	// 식당 북마크 목록 
	public List<FoodBookmarkBean> getFoodId(String id) throws Exception {
		return session.selectList("mypagens.get_foodbookmark", id);
	}
	
	// 명소 북마크 목록
	public List<PlaceBookmarkBean> getPlaceId(String id) throws Exception {
		return session.selectList("mypagens.get_placebookmark", id);
	}
	
	// 숙소 북마크 목록
	public List<RoomBookmarkBean> getRoomId(String id) throws Exception {
		return session.selectList("mypagens.get_roombookmark", id);
	}
	
	// 식당 리뷰 목록
	public List<FoodReviewBean> getFoodReview(String id) throws Exception {
		return session.selectList("mypagens.get_foodreview", id);
	}
	
	// 명소 리뷰 목록
	public List<PlaceReviewBean> getPlaceReview(String id) throws Exception {
		return session.selectList("mypagens.get_placereview", id);
	}
		
	// 숙소 리뷰 목록
	public List<RoomReviewBean> getRoomReview(String id) throws Exception {
		return session.selectList("mypagens.get_roomreview", id);
	}
	
	// 식당 문의 목록
	public List<FoodQnaBean> getFoodQna(String id) throws Exception {
		return session.selectList("mypagens.get_foodqna", id);
	}
	
	// 명소 문의 목록
	public List<PlaceQnaBean> getPlaceQna(String id) throws Exception {
		return session.selectList("mypagens.get_placeqna", id);
	}
	
	// 숙소 문의 목록
	public List<RoomQnaBean> getRoomQna(String id) throws Exception {
		return session.selectList("mypagens.get_roomqna", id);
	}
		
	// 식당 북마크 지우기
	public int delFoodMark(FoodBookmarkBean foodbookmark) throws Exception {
		return session.delete("del_foodbookmark", foodbookmark);
	}
	
	// 명소 북마크 지우기
	public int delPlaceMark(PlaceBookmarkBean placebookmark) throws Exception {
		return session.delete("del_placebookmark", placebookmark);
	}
	
	// 숙소 북마크 지우기
	public int delRoomMark(RoomBookmarkBean roombookmark) throws Exception {
		return session.delete("del_roombookmark", roombookmark);
	}
}
