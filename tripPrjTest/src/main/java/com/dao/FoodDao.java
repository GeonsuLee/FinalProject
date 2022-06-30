package com.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.model.FoodBean;
import com.model.FoodBookmarkBean;
import com.model.PlaceBean;

@Repository
public class FoodDao {

	@Autowired
	private SqlSession session;

	public List<FoodBean> getList(int page) throws Exception {
		List<FoodBean> list = session.selectList("foodns.getList", page);

		return list;
	}

	public int getCount() throws Exception {
		int count = 0;
		count = session.selectOne("foodns.getCount");

		return count;
	}
	
	/* 게시판 저장 */
	public void insertFood(FoodBean food) throws Exception {
		session.insert("foodns.write", food);
	}
	
	/* 게시판 글내용보기  */
	public FoodBean getDetail(int food_id) throws Exception {
		return session.selectOne("foodns.getDetail", food_id);
	}
	
	public List<PlaceBean> getQueryList(String city) throws Exception {
		List<PlaceBean> querylist = session.selectList("foodns.getQueryList", city);

		return querylist;
	}
	
	/* 게시물 수정 */
	public void modifyFood(FoodBean foodBean) throws Exception {
		session.update("foodns.modify", foodBean);		
	} 

	/* 게시물 삭제  */
	public void deleteFood(int food_id) throws Exception {
		session.delete("foodns.delete", food_id);				
	}
	
	public int getMarkCount(FoodBookmarkBean foodmark) throws Exception {
		
		int count = session.selectOne("foodns.getMarkCount", foodmark);
		return count;
	}
	
	public void addMark(FoodBookmarkBean foodmark) throws Exception {
		session.insert("foodns.addMark", foodmark);
	}

	public void delMark(FoodBookmarkBean foodmark) throws Exception {
		session.delete("foodns.delMark", foodmark);
	}

	// 별점 업데이트
	public void starUpdata(int food_id) throws Exception{
		session.update("foodns.starUpdata", food_id);
	}
}
