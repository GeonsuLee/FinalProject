package com.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.RoomDao;
import com.model.PlaceBean;
import com.model.RoomBean;
import com.model.RoomFilterBean;

@Service
public class RoomService {
	
	@Autowired
	private RoomDao dao;
	
	public List<RoomBean> getList(int page) throws Exception {
		return dao.getList(page);
	}
	
	public int getCount() throws Exception{
		return dao.getCount();
	}
	
	public List<RoomBean> getFilterList(RoomFilterBean roomFilter) throws Exception {
		return dao.getFilterList(roomFilter);
	}
	
	public int getFilterCount(RoomFilterBean roomFilter) throws Exception{
		return dao.getFilterCount(roomFilter);
	}
	
	/* 게시판 저장 */
	public void insert(RoomBean room) throws Exception {
		dao.insertRoom(room);
	}
	
	/* 상세정보 */
	public RoomBean detail(int room_id) throws Exception {
		RoomBean room = dao.getDetail(room_id);
		return room;
	}

	/* 게시판 수정 */
	public void modify(RoomBean roomBean) throws Exception {
		dao.modifyRoom(roomBean);
	}

	/* 게시판 삭제 */
	public void delete(int room_id) throws Exception{
		dao.deleteRoom(room_id);
	}
	
	/* 검색 */
	public List<PlaceBean> getQueryList(String city) throws Exception {
		return dao.getQueryList(city);
	}
	
	public void starUpdata(int room_id) throws Exception{
		dao.starUpdata(room_id);
	}
	
}
