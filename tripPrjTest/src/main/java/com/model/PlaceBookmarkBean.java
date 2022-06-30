package com.model;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("placebookmark")
public class PlaceBookmarkBean {
	private int place_mark_id;
	private int place_id;
	private String id;
	private String place_name;
	private String place_photo;
	private String place_addr;
	private String place_tel;
	private String place_hour;
	private String place_act;
	private String place_type;
	private String place_rate;
}
