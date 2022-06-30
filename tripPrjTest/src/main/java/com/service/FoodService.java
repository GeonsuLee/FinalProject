package com.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.dao.FoodDao;
import com.model.FoodBean;
import com.model.FoodBookmarkBean;
import com.model.PlaceBean;

@Service
public class FoodService {

	@Autowired
	private FoodDao dao;
	
	public List<FoodBean> getList(int page) throws Exception {
		return dao.getList(page);
	}
	
	public int getCount() throws Exception{
		return dao.getCount();
	}
	
	/* 게시판 저장 */
	public void insert(FoodBean food) throws Exception {
		dao.insertFood(food);
	}
	
	/* 상세정보 */
	public FoodBean detail(int food_id) throws Exception {
		FoodBean food = dao.getDetail(food_id);
		return food;
	}
	
	/* 검색 */
	public List<PlaceBean> getQueryList(String city) throws Exception {
		return dao.getQueryList(city);
	}
	
	/* 게시판 수정 */
	public void modify(FoodBean foodBean) throws Exception {			
		dao.modifyFood(foodBean);
	}
	
	/* 게시판 삭제 */
	public void delete(int food_id) throws Exception{			
		dao.deleteFood(food_id);		
	}
	
	public int getMarkCount(FoodBookmarkBean foodmark) throws Exception {
		return dao.getMarkCount(foodmark);
	}
	
	public void addMark(FoodBookmarkBean foodmark) throws Exception {
		dao.addMark(foodmark);
	}
	
	public void delMark(FoodBookmarkBean foodmark) throws Exception {
		dao.delMark(foodmark);
	}
	
	public void starUpdata(int food_id) throws Exception{
		dao.starUpdata(food_id);
	}
}
