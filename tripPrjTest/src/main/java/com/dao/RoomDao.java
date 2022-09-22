package com.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.model.PlaceBean;
import com.model.RoomBean;
import com.model.RoomFilterBean;

@Repository
public class RoomDao {

	@Autowired
	private SqlSession session;

	public List<RoomBean> getList(int page) throws Exception {
		List<RoomBean> list = session.selectList("roomns.getList", page);

		return list;
	}

	public int getCount() throws Exception {
		int count = 0;
		count = ((Integer) session.selectOne("roomns.getCount")).intValue();

		return count;
	}
	
	public List<RoomBean> getFilterList(RoomFilterBean roomFilter) throws Exception {
		List<RoomBean> list = session.selectList("roomns.getFilterList", roomFilter);

		return list;
	}
	
	public int getFilterCount(RoomFilterBean roomFilter) throws Exception {
		int count = 0;
		count = ((Integer) session.selectOne("roomns.getFilterCount", roomFilter)).intValue();

		return count;
	}
	
	/* 게시판 저장 */
	public void insertRoom(RoomBean room) throws Exception {
		session.insert("roomns.write", room);
	}
	
	/* 게시판 글내용보기  */
	public RoomBean getDetail(int room_id) throws Exception {
		return session.selectOne("roomns.getDetail", room_id);
	}

	/* 게시물 수정 */
	public void modifyRoom(RoomBean roomBean) throws Exception {
		session.update("roomns.modify", roomBean);
	}

	/* 게시물 삭제  */
	public void deleteRoom(int room_id) throws Exception {
		session.delete("roomns.delete", room_id);
	}
	
	public List<PlaceBean> getQueryList(String city) throws Exception {
		List<PlaceBean> querylist = session.selectList("placens.getQueryList", city);
		
		return querylist;
	}
	
	// 별점 업데이트
		public void starUpdata(int room_id) throws Exception{
			session.update("roomns.starUpdata", room_id);
		}
	
}
