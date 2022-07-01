package com.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.PlaceDao;
import com.model.PlaceBean;
import com.model.PlaceBookmarkBean;
import com.model.PlaceFilterBean;
import com.model.RoomBean;
import com.model.RoomFilterBean;

@Service
public class PlaceService {

	@Autowired
	private PlaceDao dao;

	public List<PlaceBean> getList(int page) throws Exception {
		return dao.getList(page);
	}

	public int getCount() throws Exception {
		return dao.getCount();
	}
	
	public List<PlaceBean> getFilterList(PlaceFilterBean placeFilter) throws Exception {
		return dao.getFilterList(placeFilter);
	}
	
	public int getFilterCount(PlaceFilterBean placeFilter) throws Exception{
		return dao.getFilterCount(placeFilter);
	}
	
	/* 게시판 저장 */
	public void insert(PlaceBean place) throws Exception {
		dao.insertPlace(place);
	}
	
	/* 상세정보 */
	public PlaceBean detail(int place_id) throws Exception {
		PlaceBean place = dao.getDetail(place_id);
		return place;
	}
	
	/* 검색 */
	public List<PlaceBean> getQueryList(String city) throws Exception {
		return dao.getQueryList(city);
	}
	
	/* 게시판 수정 */
	public void modify(PlaceBean placeBean) throws Exception {			
		dao.modifyPlace(placeBean);
	}
	
	/* 게시판 삭제 */
	public void delete(int place_id) throws Exception{			
		dao.deletePlace(place_id);		
	}
	
	public int getMarkCount(PlaceBookmarkBean placemark) throws Exception {
		return dao.getMarkCount(placemark);

	}

	public void addMark(PlaceBookmarkBean placemark) throws Exception {
		dao.addMark(placemark);
	}

	public void delMark(PlaceBookmarkBean placemark) throws Exception {
		dao.delMark(placemark);
	}
	
	public void starUpdata(int place_id) throws Exception{
		dao.starUpdata(place_id);
	}
}
