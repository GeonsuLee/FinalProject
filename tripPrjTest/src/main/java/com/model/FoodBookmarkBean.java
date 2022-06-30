package com.model;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("foodbookmark")
public class FoodBookmarkBean {
	private int food_mark_id;
	private int food_id;
	private String id;
	private String food_name;		
	private String food_photo;		
	private String food_addr;		
	private String food_hour;		
	private String food_feat;		 	
	private String food_type;		
	private String food_rate;
}
