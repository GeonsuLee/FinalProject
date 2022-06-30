package com.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.MainDao;
import com.model.FoodBean;
import com.model.MemberBean;
import com.model.PlaceBean;
import com.model.RoomBean;
import com.model.RoomFilterBean;
import com.model.SearchBean;

@Service
public class MainService {

	@Autowired
	private MainDao dao;

	public MemberBean getMember(String id) throws Exception {
		return dao.getMember(id);
	}

	public List<PlaceBean> getPlaceList() throws Exception {
		return dao.getPlaceList();
	}

	public List<FoodBean> getFoodList() throws Exception {
		return dao.getFoodList();
	}

	public List<RoomBean> getRoomList() throws Exception {
		return dao.getRoomList();
	}

	public List<PlaceBean> getSearchList(SearchBean search) throws Exception {
		return dao.getSearchList(search);
	}

	public int getSearchCount(SearchBean search) throws Exception {
		return dao.getSearchCount(search);
	}

}
