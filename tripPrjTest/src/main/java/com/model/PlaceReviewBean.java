package com.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("placeReview")
public class PlaceReviewBean {
	
	private int place_rev_id;
	private String rev_title;
	private String rev_content;
	private String rev_photo;
	private Date rev_reg;
	private double rev_rate;
	private int rev_like;
	private int place_id;
	private String id;
	private String userphoto;

}
