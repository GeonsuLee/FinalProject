package com.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.model.FoodBean;
import com.model.MemberBean;
import com.model.PlaceBean;
import com.model.RoomBean;
import com.model.RoomFilterBean;
import com.model.SearchBean;

@Repository
public class MainDao {

	@Autowired
	private SqlSession session;

	public MemberBean getMember(String id) throws Exception {
		return session.selectOne("mainns.getMember", id);
	}

	public List<PlaceBean> getPlaceList() throws Exception {
		List<PlaceBean> placeList = session.selectList("mainns.getPlaceList");

		return placeList;
	}

	public List<FoodBean> getFoodList() throws Exception {
		List<FoodBean> foodList = session.selectList("mainns.getFoodList");

		return foodList;
	}

	public List<RoomBean> getRoomList() throws Exception {
		List<RoomBean> roomList = session.selectList("mainns.getRoomList");

		return roomList;
	}

	public List<PlaceBean> getSearchList(SearchBean search) throws Exception {
		List<PlaceBean> searchList = session.selectList("mainns.getSearchList", search);

		return searchList;
	}

	public int getSearchCount(SearchBean search) throws Exception {
		int count = 0;
		count = ((Integer) session.selectOne("mainns.getSearchCount", search)).intValue();

		return count;
	}

}
