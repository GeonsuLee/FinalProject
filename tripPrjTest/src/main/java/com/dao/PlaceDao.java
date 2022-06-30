package com.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.model.PlaceBean;
import com.model.PlaceBookmarkBean;
import com.model.PlaceFilterBean;
import com.model.RoomBean;
import com.model.RoomFilterBean;

@Repository
public class PlaceDao {

	@Autowired
	private SqlSession session;

	public List<PlaceBean> getList(int page) throws Exception {
		List<PlaceBean> list = session.selectList("placens.getList", page);

		return list;
	}

	public int getCount() throws Exception {
		int count = 0;
		count = ((Integer) session.selectOne("placens.getCount")).intValue();

		return count;
	}
	
	public List<PlaceBean> getFilterList(PlaceFilterBean placeFilter) throws Exception {
		List<PlaceBean> list = session.selectList("placens.getFilterList", placeFilter);

		return list;
	}
	
	public int getFilterCount(PlaceFilterBean placeFilter) throws Exception {
		int count = 0;
		count = ((Integer) session.selectOne("placens.getFilterCount", placeFilter)).intValue();

		return count;
	}
	
	/* 게시판 저장 */
	public void insertPlace(PlaceBean place) throws Exception {
		session.insert("placens.write", place);
	}
	
	/* 게시판 글내용보기  */
	public PlaceBean getDetail(int place_id) throws Exception {
		return session.selectOne("placens.getDetail", place_id);
	}
	
	public List<PlaceBean> getQueryList(String city) throws Exception {
		List<PlaceBean> querylist = session.selectList("placens.getQueryList", city);
		
		return querylist;
	}
	
	/* 게시물 수정 */
	public void modifyPlace(PlaceBean placeBean) throws Exception {
		session.update("placens.modify", placeBean);
	}
	
	
	/* 게시물 삭제  */
	public void deletePlace(int place_id) throws Exception {
		session.delete("placens.delete", place_id);				
	}
	
	public int getMarkCount(PlaceBookmarkBean placemark) throws Exception {

		int count = session.selectOne("placens.getMarkCount", placemark);
		return count;
	}

	public void addMark(PlaceBookmarkBean placemark) throws Exception {
		session.insert("placens.addMark", placemark);
	}

	public void delMark(PlaceBookmarkBean placemark) throws Exception {
		session.delete("placens.delMark", placemark);
	}

}
