package com.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("foodReply")
public class FoodReplyBean {
	private int food_reply_id;
	private String reply_content;
	private Date reply_reg;
	private int food_rev_id;
	private String id;
	private String userphoto;

}
