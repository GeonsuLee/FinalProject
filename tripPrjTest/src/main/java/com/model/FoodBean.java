package com.model;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("food")
public class FoodBean {
	private int food_id;
	private String food_name;
	private String food_content;
	private String food_photo;
	private String food_addr;
	private String food_tel;
	private String food_hour;
	private String food_feat;
	private String food_type;
	private String food_menu;
	private int food_cost;
	private double food_rate;
	private String admin_id;
}
