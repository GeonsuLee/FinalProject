package com.model;

import java.sql.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Data
@Alias("placeReply")
public class PlaceReplyBean {
	private int place_reply_id;
	private String reply_content;
	private Date reply_reg;
	private int place_rev_id;
	private String id;
	private String userphoto;

}
