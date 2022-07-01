package com.model;

import org.apache.ibatis.type.Alias;
import lombok.Data;

@Data
@Alias("place")
public class PlaceBean {
	private int place_id;
	private String place_name;
	private String place_content;
	private String place_photo;
	private String place_addr;
	private String place_tel;
	private String place_hour;
	private String place_act;
	private String place_type;
	private double place_rate;
	private String admin_id;
}
