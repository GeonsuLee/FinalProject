package com.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("foodLike")
public class FoodLikeBean {
	
	private int food_like_id;
	private int food_rev_id;
	private String id;
	
}
